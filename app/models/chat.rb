class Chat < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :messages, :order => :created_at 
end
