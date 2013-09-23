class AddCommentsCountToPost < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer
    Post.all.each{|p|  Post.reset_counters(p.id, :comments) }
  end
end
