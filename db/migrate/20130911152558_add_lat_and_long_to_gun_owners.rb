class AddLatAndLongToGunOwners < ActiveRecord::Migration
  def change
    add_column :gun_owners, :latitude, :float
    add_column :gun_owners, :longitude, :float
  end
end
