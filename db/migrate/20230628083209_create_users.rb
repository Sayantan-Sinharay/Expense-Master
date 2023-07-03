class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :remember_me?, null: false, default: false
      t.boolean :is_admin?, null: false, default: false
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.references :organization, null: false, foreign_key: true
      t.timestamps
    end
  end
end
