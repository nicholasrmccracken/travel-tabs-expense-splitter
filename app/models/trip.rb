class Trip < ApplicationRecord
  # A Trip belongs to an owner (a User)
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  # A Trip has many Users through Participant
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  # A Trip has many Expenses
  has_many :expenses, dependent: :destroy
end
