class Ueditor::Asset < ActiveRecord::Base
  self.table_name = "ueditor_assets"

  attr_accessible :title, :data
  has_attached_file :data

  validates :data, presence:true
end
