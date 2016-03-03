class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :chq_number
      t.date :chq_date
      t.string :category
      t.integer :deal_id
      t.string :particular
      t.string :currencies
      t.decimal :amount
      t.string :prepared
      t.date :sign_date
      t.date :present_date
      t.string :status

      t.timestamps null: false
    end
  end
end
