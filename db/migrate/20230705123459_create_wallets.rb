# frozen_string_literal: true

# Represents a migration to create the wallets table.
class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.integer :month, null: false
      t.integer :year, null: false, default: -> { 'EXTRACT(year FROM CURRENT_TIMESTAMP)' }
      t.timestamps
    end

    add_index :wallets, :year
    add_index :wallets, %i[user_id month]
    add_index :wallets, %i[month year]
  end
end
