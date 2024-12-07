class ExpenseParticipant < ApplicationRecord
  belongs_to :expense
  belongs_to :user

  # Tracks the share of the expense attributed to the user
  # E.g., percentage or specific amount
  validates :share, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # Update users balance in Leagure when expense payed
  def update_leagure_balance
    leaguer = Participant.find_or_create_by(trip: expense.trip, user: user)
    leaguer.amount_owed += share
    leaguer.save
  end
end
