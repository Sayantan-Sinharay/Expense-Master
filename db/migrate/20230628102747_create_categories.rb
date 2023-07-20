# frozen_string_literal: true

# Represents a migration to create the categories table.
class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
