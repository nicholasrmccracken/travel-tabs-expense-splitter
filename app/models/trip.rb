class Trip < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :expenses, dependent: :destroy

  validates :name, presence: true
end
