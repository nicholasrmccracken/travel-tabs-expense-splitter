class CreateExpenseParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_participants do |t|
      t.references :expense, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :share, precision: 10, scale: 2
      t.timestamps
    end
  end
end
