class AddDefaultValuesToParticipants < ActiveRecord::Migration[7.0]
  def change
    change_column_default :participants, :amount_owed, 0.0
    change_column_default :participants, :amount_paid, 0.0
  end
end
