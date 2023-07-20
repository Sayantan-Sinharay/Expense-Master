# frozen_string_literal: true

# Represents a migration to create the subcategories table.
class CreateSubcategories < ActiveRecord::Migration[6.1]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
