class Media < ActiveRecord::Base
  attr_accessible :title, :description, :path
  validates_presence_of :title, :path
end
