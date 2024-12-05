class AddShareTypeToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_column :expenses, :share_type, :string
  end
end
