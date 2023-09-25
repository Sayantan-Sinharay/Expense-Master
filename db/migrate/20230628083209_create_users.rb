# rubocop:disable all
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :remember_me?, null: false, default: false
      t.boolean :is_admin?, null: false, default: false
      t.datetime :invitation_sent_at
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.timestamps
    end

    add_index :users, [:email, :organization_id], unique: true
  end
end
