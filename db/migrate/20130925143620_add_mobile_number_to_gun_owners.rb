class AddMobileNumberToGunOwners < ActiveRecord::Migration
  def change
    add_column :gun_owners, :mobile_number, :string
  end
end
