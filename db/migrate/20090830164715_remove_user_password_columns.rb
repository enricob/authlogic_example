class RemoveUserPasswordColumns < ActiveRecord::Migration
  def self.up
    remove_column :users, :crypted_password
    remove_column :users, :password_salt
  end

  def self.down
    add_column :users, :string, :crypted_password, :null => false
    add_column :users, :string, :password_salt, :null => false
  end
end
