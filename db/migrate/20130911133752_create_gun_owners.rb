class CreateGunOwners < ActiveRecord::Migration
  def change
    create_table :gun_owners do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :province
      t.string :region

      t.timestamps
    end
  end
end
