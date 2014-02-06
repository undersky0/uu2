
require 'facebook_wrapper'
include FacebookWrapperModule
class FriendmapController < ApplicationController
  def index
    user_id = session[:user_id]
    @friends = []

    if !user_id.nil?
      au = Authenticatio.find_by_user_id(current_user.id)
      oauth_token = au.token
      @friends = get_friends(oauth_token)
    end


  @hash = Gmaps4rails.build_markers(@friends) do |friend, marker|
  marker.lat friend.latitude
  marker.lng friend.longitude
  end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friends }
    end

# 
    # @json = @friends.to_gmaps4rails
    # respond_to do |format|
      # format.html # index.html.erb
      # format.json { render json: @friends }
    # end
  end

  private

  def get_friends(oauth_token)
    fb_friends = FacebookWrapper.get_fb_friends(oauth_token)
    friends = FacebookWrapper.from_fb_friends(fb_friends) { |fb_friend, location|
      friend = Mappedfriends.new
      friend.uid = fb_friend["uid"]
      friend.name = fb_friend["name"]
      friend.pic = fb_friend["pic_square"]
      friend.profile_url = fb_friend["profile_url"]
      friend.address = location["name"]
      friend.latitude = location["latitude"]
      friend.longitude = location["longitude"]
      friend.gmaps = true

      friend
    }

    friends
  end
end
