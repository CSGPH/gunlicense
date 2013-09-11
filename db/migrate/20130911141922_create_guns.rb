class CreateGuns < ActiveRecord::Migration
  def change
    create_table :guns do |t|
      t.string :serial_number
      t.string :kind
      t.string :make
      t.string :caliber
      t.string :model
      t.date :issued_date
      t.date :expiry_date
      t.integer :gun_owner_id

      t.timestamps
    end
    add_index :guns, :gun_owner_id
  end
end
