class UpdateColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :contact_number, :mobile_number
  end
end
