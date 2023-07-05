class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :subcategory, foreign_key: true
      t.date :date
      t.decimal :amount, precision: 10, scale: 2
      t.text :notes
      t.string :attachments
      t.integer :status
      t.timestamps
    end
  end
end