class AddDeviseToAdmins < ActiveRecord::Migration[6.1]
  def change
    
    unless column_exists?(:admins, :email)
      add_column :admins, :email, :string, null: false, default: ""
    end

    unless column_exists?(:admins, :encrypted_password)
      add_column :admins, :encrypted_password, :string, null: false, default: ""
    end

    
    unless column_exists?(:admins, :reset_password_token)
      add_column :admins, :reset_password_token, :string
    end
    unless column_exists?(:admins, :reset_password_sent_at)
      add_column :admins, :reset_password_sent_at, :datetime
    end

  
    unless column_exists?(:admins, :remember_created_at)
      add_column :admins, :remember_created_at, :datetime
    end

    
    add_index :admins, :email, unique: true unless index_exists?(:admins, :email)
    add_index :admins, :reset_password_token, unique: true unless index_exists?(:admins, :reset_password_token)
  end
end
