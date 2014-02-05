class Localfeed < ActiveRecord::Base
  attr_accessible :city, :scribble_id, :location_id, :localfeed_id, :scribble_attributes, :localfeed_attributes
  
  belongs_to :location
  has_many :scribbles, :as => :scribbled
  accepts_nested_attributes_for :scribbles
  validates :city, :presence => true, :uniqueness => true
  
  # after_validation :savefeed
#   
#   
#   
#   
  # def savefeed
    # self.save!
  # end
end
