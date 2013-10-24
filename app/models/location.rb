class Location < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  acts_as_gmappable
  belongs_to :user
  attr_accessible :address, :gmaps, :latitude, :longitude, :postcode, :user_id
  
  geocoded_by :address
  
  after_validation :geocode
  
  
  
  
  
  def gmaps4rails_address
    address
  end
  
  
end
