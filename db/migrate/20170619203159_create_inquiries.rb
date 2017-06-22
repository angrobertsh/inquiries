class CreateInquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :inquiries do |t|
      t.integer :user_id, null: false
      t.integer :unit_id, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.decimal :taxes_withheld, :precision => 8, :scale => 2
      t.decimal :total_price, :precision => 8, :scale => 2

      t.timestamps
    end
    add_index :inquiries, [:user_id, :unit_id]
  end
end
