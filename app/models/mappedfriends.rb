class Mappedfriends < ActiveRecord::Base
  acts_as_gmappable

  # Fields we get from FB
  attr_accessible :uid, :name, :pic, :address, :profile_url
  # Fields required by gmaps4rails (lat and long also come from FB)
  attr_accessible :gmaps, :latitude, :longitude

  # gmaps4rails methods
  def gmaps4rails_address
    address
  end

def gmaps4rails_infowindow
    "<p><a href = '#{profile_url}' target='_blank'>#{name}</a><br>#{address}<br><img src = '#{pic}'/></p>"
  end
  end
