class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :owner, :foreign_key => :owner_id, :class_name =>'User'
  def commenter
    owner.email if owner
  end
  attr_accessible :body, :commenter
end
