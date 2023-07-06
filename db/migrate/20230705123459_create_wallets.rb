class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount_given, precision: 10, scale: 2
      t.date :month
      t.timestamps
    end
  end
end
