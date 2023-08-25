# frozen_string_literal: true

# Represents a migration to create the categories table.
class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.references :organization, null: false, foreign_key: true
      t.timestamps
    end

    add_index :categories, :name
  end
end
