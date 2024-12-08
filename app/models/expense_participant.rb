class ExpenseParticipant < ApplicationRecord
  belongs_to :expense
  belongs_to :user

  # Tracks the share of the expense attributed to the user
  # E.g., percentage or specific amount
  validates :share_value, numericality: { greater_than_or_equal_to: 0 }, presence: true

  # Calculate amount owed for the expense.
  def amount_owed
    if expense.share_type == 'percentage'
      (share_value / 100.0) * expense.amount
    else
      share_value
    end
  end
end
