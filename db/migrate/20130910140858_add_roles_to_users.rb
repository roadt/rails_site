class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles, :integer, :default => 0
    User.all.each {|u| u.grant_commenter.save!}
    User.find(1).grant_owner.save!
  end

  def down
    remove_column :users, :roles
  end
end
