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

  accepts_nested_attributes_for :expense_participants, allow_destroy: true

  CATEGORIES = ['Entertainment', 'Food and Drink', 'Lodging', 'Other', 'Transportation'].freeze
  validates :category, inclusion: { in: CATEGORIES }

  private

  # Update Expense model to track when payments are made
  def update_leagures_for_shared_users
    users.each do |user|
      # Calculate the share for each user
      share = amount / users.count
      ExpenseParticipant.create(expense: self, user: user, share: share)

      # Update the Leaguer model to reflect the amount each user owes
      ExpenseParticipant.last.update_leagure_balance
    end
  end

  def validate_share
    if share_type == 'percentage' && share_value > 100 # rubocop:disable Style/GuardClause
      errors.add(:share_value, 'Percentage can\'t exceed 100.')
    end
  end
end
