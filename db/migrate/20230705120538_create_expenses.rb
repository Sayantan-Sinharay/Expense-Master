# rubocop:disable all
# frozen_string_literal: true

# Represents a migration to create the expenses table.
class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, foreign_key: true
      t.date :date
      t.integer :month, null: false
      t.integer :year, null: false, default: -> { "EXTRACT(year FROM CURRENT_TIMESTAMP)" }
      t.decimal :amount, precision: 10, scale: 2
      t.text :notes
      t.string :attachment
      t.integer :status, default: 0, null: false
      t.text :rejection_reason
      t.timestamps
    end
  end
end
