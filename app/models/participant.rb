class Participant < ApplicationRecord
  # A Participant belongs to a Trip
  belongs_to :trip

  # A Participant belongs to a User
  belongs_to :user

  # A Participant cannot be added multiple times to the same Trip
  validates :user_id, uniqueness: { scope: :trip_id, message: 'is already a participant in this trip' }
end
