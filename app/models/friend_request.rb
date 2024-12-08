class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :status, inclusion: { in: %w[pending accepted rejected], message: '%<value>s is not a valid status' }
  validates :sender, presence: true
  validates :receiver, presence: true
  validate :not_self

  private

  # Prevent sending a friend request to yourself
  def not_self
    errors.add(:receiver, "can't be the same as sender") if sender_id == receiver_id
  end
end
