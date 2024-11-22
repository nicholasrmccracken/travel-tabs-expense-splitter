class AddCreatorToExpenses < ActiveRecord::Migration[7.0]
  def change
    add_reference :expenses, :creator, null: false, foreign_key: { to_table: :users }
  end
end
