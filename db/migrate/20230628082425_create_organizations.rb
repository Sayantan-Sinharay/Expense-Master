# frozen_string_literal: true

# Represents a migration to create the organizations table.
class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
