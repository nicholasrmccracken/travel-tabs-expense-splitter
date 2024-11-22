class Expense < ApplicationRecord
  # An Expense belongs to a Trip
  belongs_to :trip

  # An Expense belongs to a creator (a User)
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  # An Expense can be shared among multiple Users
  has_and_belongs_to_many :shared_users, class_name: 'User', join_table: 'expenses_users'
end
