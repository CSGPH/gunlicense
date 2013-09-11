class RenameUserIdInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :user_id, :gun_owner_id
    rename_index  :users, "user_id", "gun_owner_id"
  end
end
