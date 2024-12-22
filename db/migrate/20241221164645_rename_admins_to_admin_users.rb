class RenameAdminsToAdminUsers < ActiveRecord::Migration[6.1]
  def change
      rename_table :admins, :admin_users
    end
  end