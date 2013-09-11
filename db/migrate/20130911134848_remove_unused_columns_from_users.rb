class RemoveUnusedColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    remove_column :users, :address, :string
    remove_column :users, :mobile_number, :string
  end
end
