class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :remember_me, null: false, default: false
      t.boolean :is_admin, null: false, default: false
      t.references :organization, null: false, foreign_key: true
      t.timestamps
    end
  end
end