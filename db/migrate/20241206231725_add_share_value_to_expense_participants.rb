class AddShareValueToExpenseParticipants < ActiveRecord::Migration[7.0]
  def change
    return if column_exists?(:expense_participants, :share_value)

    add_column :expense_participants, :share_value, :decimal, precision: 10, scale: 2
  end
end
