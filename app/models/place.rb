class Place < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :locationable, :polymorphic => true
  belongs_to :location
end
