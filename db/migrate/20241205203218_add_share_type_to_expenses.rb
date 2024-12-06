class AddShareTypeToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :share_type, :string, default: 'amount'
    add_column :expenses, :share_value, :decimal, precision: 10, scale: 2
  end
end
