class RemoveAdminUserFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :admin_user, :boolean
  end
end
