class Participant < ApplicationRecord
  # A Participant belongs to a Trip
  belongs_to :trip

  # A Participant belongs to a User
  belongs_to :user

  # Amount calculations for owed and paid amounts
  validates :amount_owed, numericality: { greater_than_or_equal_to: 0 }
  validates :amount_paid, numericality: { greater_than_or_equal_to: 0 }

  # handle valid payment
  def make_payment(amount)
    if valid_payment_amount?(amount)
      record_payment(amount)
    else
      errors.add(:amount_paid, 'Payment amount exceeds balance owed')
    end
  end

  private

  # mark off leadure
  def record_payment(amount)
    self.amount_paid += amount
    save
  end

  # does payment exceed amount owed
  def valid_payment_amount?(amount)
    amount.positive? && amount <= (amount_owed - amount_paid)
  end
end
