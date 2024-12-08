class Expense < ApplicationRecord
  # An Expense belongs to a Trip
  belongs_to :trip

  # An Expense belongs to a creator (a User)
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  # An Expense can be shared among multiple Users in different proportions
  has_many :expense_participants, dependent: :destroy
  has_many :users, through: :expense_participants, source: :user

  after_create :update_leagures_for_shared_users
  validate :validate_share
  validates :share_type, inclusion: { in: %w[amount percentage], message: "must be 'amount' or 'percentage'" }
  CATEGORIES = ['Entertainment', 'Food and Drink', 'Lodging', 'Other', 'Transportation'].freeze
  validates :category, inclusion: { in: CATEGORIES }

  accepts_nested_attributes_for :expense_participants, allow_destroy: true

  private

  # Automatically distribute expense evenly.
  def update_leagures_for_shared_users
    return unless expense_participants.empty?

    equal_share = share_type == 'amount' ? (amount / users.count) : (100.0 / users.count)
    users.each do |user|
      expense_participants.create(user: user, share_value: equal_share)
    end
  end

  # Check sum of shares is valid.
  def validate_share
    total_share = expense_participants.sum { |participant| participant.share_value.to_i }

    if share_type == 'percentage' && total_share != 100
      errors.add(:base, 'Total percentage must equal 100%.')
    elsif share_type == 'amount' && total_share != amount
      errors.add(:base, 'Total share amount must equal the expense amount.')
    end
  end
end
