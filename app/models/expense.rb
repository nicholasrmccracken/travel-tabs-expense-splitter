class Expense < ApplicationRecord
  # An Expense belongs to a Trip
  belongs_to :trip

  # An Expense belongs to a creator (a User)
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  # An Expense can be shared among multiple Users in different proportions
  has_many :expense_participants, dependent: :destroy
  has_many :shared_users, through: :expense_participants, source: :user

  after_create :update_leagures_for_shared_users

  private

  # Update Expense model to track when payments are made
  def update_leagures_for_shared_users
    shared_users.each do |user|
      # Calculate the share for each user
      share = amount / shared_users.count
      ExpenseParticipant.create(expense: self, user: user, share: share)

      # Update the Leaguer model to reflect the amount each user owes
      ExpenseParticipant.last.update_leaguer_balance
    end
  end
end
