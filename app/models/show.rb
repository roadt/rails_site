class Show < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :show_data
end
