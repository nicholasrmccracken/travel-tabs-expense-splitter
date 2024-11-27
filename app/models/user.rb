class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # User can own many trips
  has_many :owned_trips, class_name: 'Trip', foreign_key: 'owner_id', dependent: :destroy

  # User can participate in many trips through Participant
  has_many :participants, class_name: 'Participant', dependent: :destroy
  has_many :trips, through: :participants

  # User can create many expenses
  has_many :created_expenses, class_name: 'Expense', foreign_key: 'creator_id', dependent: :destroy

  # User can share expenses through ExpenseParticipants
  has_many :expense_participants, dependent: :destroy
  has_many :shared_expenses, through: :expense_participants, source: :expense
end
