class Location < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  acts_as_gmappable
  has_many :places, :dependednt => :destroy
  has_many :users, :through => :places, :source => :locationable, :source_type => "User", :foreign_key => "actor_id"
  attr_accessible :address, :gmaps, :latitude, :longitude, :postcode, :user_id, :actor_id
  
  geocoded_by :address
  #before_save :geolocate
  after_validation :geocode
  
  
  
  def to_s
    "#{address}" + ", UK"
  end
  
  def gmaps4rails_address
    address
  end
  
  protected
  
  def geolocate 
    res = GoogleGeocoder.geocode(to_s)
    if res.success
    self.latitude = res.lat
    self.lonitude = res.lng
    else
      errors[:base] << "geocoding failed, check address"
      return false
  end
  end
  
end
