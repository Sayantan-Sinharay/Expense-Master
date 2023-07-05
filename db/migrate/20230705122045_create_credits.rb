class CreateCredits < ActiveRecord::Migration[6.1]
  def change
    create_table :credits do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.date :date
      t.references :beneficiary_user, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
