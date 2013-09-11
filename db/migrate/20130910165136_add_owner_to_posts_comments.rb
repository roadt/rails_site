class AddOwnerToPostsComments < ActiveRecord::Migration
  def change
    add_column :posts, :owner_id, :integer

    remove_column :comments, :commenter
    add_column :comments, :owner_id, :integer
  end
end
