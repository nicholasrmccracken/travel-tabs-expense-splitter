class ExpenseParticipant < ApplicationRecord
  # An ExpenseParticipant belongs to an Expense
  belongs_to :expense

  # An ExpenseParticipant belongs to a User
  belongs_to :user

  # Tracks the share of the expense attributed to the user
  # E.g., percentage or specific amount
  validates :share, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
end
