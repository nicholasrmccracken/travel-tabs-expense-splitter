class Expense < ApplicationRecord
  # An Expense belongs to a Trip
  belongs_to :trip

  # An Expense belongs to a creator (a User)
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  # An Expense can be shared among multiple Users in different proportions
  has_many :expense_participants, dependent: :destroy
  has_many :shared_users, through: :expense_participants, source: :user
end
