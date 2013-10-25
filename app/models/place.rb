class Place < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :locationable, :polymorphics => true
  belongs_to :location
end
