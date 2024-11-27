class Trip < ApplicationRecord
  # A Trip belongs to an owner (a User)
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  # A Trip has many participants through Participant
  has_many :participants, dependent: :destroy

  # A Trip has many Expenses
  has_many :expenses, dependent: :destroy

  # The owner cannot be a Participant in a Trip
  validate :owner_not_participant

  # Track amounts owed and payed
  has_many :leaguers, dependent: :destroy
  has_many :users, through: :leaguers

  private

  def owner_not_participant
    return unless participants.include?(owner)

    errors.add(:owner, 'cannot also be a participant in the trip')
  end
end
