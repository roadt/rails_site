class ShowData < ActiveRecord::Base
  attr_accessible :db, :host, :pass, :port, :show, :table, :user
  belongs_to :show
end
