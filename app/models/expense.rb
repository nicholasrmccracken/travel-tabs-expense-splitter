class Expense < ApplicationRecord
  CATEGORIES = ['Entertainment', 'Food and Drink', 'Lodging', 'Other', 'Transportation'].freeze

  belongs_to :trip
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  has_many :expense_participants, dependent: :destroy
  has_many :users, through: :expense_participants, source: :user

  validates :category, inclusion: { in: CATEGORIES }
  validate :validate_share
  validates :share_type, inclusion: { in: %w[amount percentage], message: "must be 'amount' or 'percentage'" }

  accepts_nested_attributes_for :expense_participants, allow_destroy: true

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

  # def validate_share
  #  if share_type == 'percentage' && expense_participants.share_value > 100
  #    errors.add(:share_value, 'Percentage can\'t exceed 100.')
  #  end
  # end
  def validate_share
    return unless share_type == 'percentage'

    expense_participants.each do |participant|
      if participant.share_value.nil?
        errors.add(:base, 'Participant share value must be present.')
      elsif participant.share_value > 100
        errors.add(:base, "Participant share value can't exceed 100%.")
      end
    end
  end
end
