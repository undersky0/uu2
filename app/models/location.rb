class Location < ActiveRecord::Base
  
  
  
  has_many :users, :through => :places, :source => :locationable, :source_type => "User", :foreign_key => 'actor_id'
  has_many :places
  #has_many :locationables, :through => :places
  
  
  attr_accessible :address, :latitude, :longitude, :postcode, :user_id, :actor_id,
    :country,  
    :country_code,  
    :postal_code,  
    :city,  
    :political,  
    :locality,  
    :sublocality,  
    :street_address
      
  geocoded_by :address
  #before_save :geolocate
  
  after_validation :geocode
  #before_save :geolocate
  
  
  def to_s
    "#{address}" +" GB"
  end
  
  def gmaps4rails_address
    address
  end
  
  protected
  
  
    geocoded_by :address do |prof,results|
  if result = results.select{|res| res.country_code == "GB" }.first
    unless (result.latitude.nil? || result.longitude.nil?)
      prof.latitude = result.latitude
      prof.longitude = result.longitude
      prof.country = result.country
      prof.postal_code = result.postal_code
      prof.city = result.city
      #prof.political = result.political
      prof.locality = result.locality
      prof.sublocality = result.sublocality
      prof.street_address = result.street_address
    end
    result.coordinates
  end
end
  
  def geolocate 
    res = GoogleGeocoder.geocode(to_s)
    
    if res.success
    self.
    self.latitude = res.latitude
    self.lonitude = res.longitude
    else
      errors[:base] << "geocoding failed, check address"
      return false
  end
  end
  
  
  
end
