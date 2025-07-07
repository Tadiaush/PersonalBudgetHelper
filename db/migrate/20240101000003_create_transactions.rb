class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: true, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string :description, null: false
      t.string :transaction_type, null: false
      t.date :date, null: false

      t.timestamps
    end

    add_index :transactions, [:user_id, :date]
    add_index :transactions, [:user_id, :transaction_type]
  end
end