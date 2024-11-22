class CreateExpensesUsersJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :expenses, :users do |t|
      t.index :expense_id
      t.index :user_id
    end
  end
end
