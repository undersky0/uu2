class Location < ActiveRecord::Base
  
  acts_as_gmappable
  
  attr_accessible :address, :gmaps, :latitude, :longitude, :postcode
  
  def gmaps4rails_address
    address
  end
  
  
end
