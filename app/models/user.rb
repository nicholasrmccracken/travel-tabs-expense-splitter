class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # User can own many trips
  has_many :owned_trips, class_name: 'Trip', foreign_key: 'owner_id', dependent: :destroy

  # User can participate in many trips through Participant
  has_many :participants, dependent: :destroy
  has_many :trips, through: :participants

  # User can create many expenses
  has_many :created_expenses, class_name: 'Expense', foreign_key: 'creator_id', dependent: :destroy

  # User can share expenses through ExpenseParticipants
  has_many :expense_participants, dependent: :destroy
  has_many :shared_expenses, through: :expense_participants, source: :expense

  # User can pay debts through trips
  has_many :leaguers, dependent: :destroy
  has_many :trips, through: :leaguers

  # Calculate amount owed based on share of expenses
  def total_owed_for_trip(trip)
    leaguer = Leaguer.find_by(trip: trip, user: self)
    leaguer&.amount_owed || 0.0
  end

  # Calculate amount user has payed off
  def total_paid_for_trip(trip)
    leaguer = Leaguer.find_by(trip: trip, user: self)
    leaguer&.amount_paid || 0.0
  end
end
