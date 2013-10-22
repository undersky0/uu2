class Location < ActiveRecord::Base
  attr_accessible :address, :gmaps, :latitude, :longitude, :postcode
end
