# frozen_string_literal: true

# Represents a migration to create the notifications table.
class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :message
      t.boolean :read, default: false
      t.timestamps
    end

    add_index :notifications, :read
  end
end
