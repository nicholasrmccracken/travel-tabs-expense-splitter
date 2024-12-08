class Expense < ApplicationRecord
  CATEGORIES = ['Entertainment', 'Food and Drink', 'Lodging', 'Other', 'Transportation'].freeze

  belongs_to :trip
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  has_many :expense_participants, dependent: :destroy
  has_many :users, through: :expense_participants, source: :user

  validates :category, inclusion: { in: CATEGORIES }
  validate :validate_share
  validates :share_type, inclusion: { in: %w[amount percentage], message: "must be 'amount' or 'percentage'" }

  accepts_nested_attributes_for :expense_participants, allow_destroy: true, reject_if: lambda { |attributes|
    attributes['share_value'].blank? || attributes['share_value'].to_f <= 0
  }

  private

  # Check sum of shares is valid.
  def validate_share
    valid_participants = expense_participants.reject do |participant|
      participant.share_value.blank? || participant.share_value <= 0
    end
    total_share = valid_participants.sum { |participant| participant.share_value.to_f }

    if share_type == 'percentage' && total_share != 100
      errors.add(:base, 'Total percentage must equal 100%.')
    elsif share_type == 'amount' && total_share != amount
      errors.add(:base, 'Total share amount must equal the expense amount.')
    end
  end
end
