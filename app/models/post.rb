class Post < ActiveRecord::Base
  
  attr_accessible :content, :name, :title, :tag_list
#  validates :name, :presence => true
  validates :title, :presence => true, :length => { :minimum => 5 }

  has_many :comments, :dependent => :destroy
  belongs_to :owner,  :class_name => 'User'

  #  taggable
  acts_as_taggable
end
