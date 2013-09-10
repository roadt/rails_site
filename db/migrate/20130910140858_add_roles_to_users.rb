class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles, :integer, :default => 0
    User.all.each {|u| u.grant_commenter}
    User.find(1).grant_owner
  end

  def down
    remove_column :users, :roles
  end
end
