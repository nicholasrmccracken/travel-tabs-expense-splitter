class AddParticipantsDebts < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :amount_owed, :decimal
    add_column :participants, :amount_paid, :decimal
  end
end
