class LandingPageController < ApplicationController
  def index
    @locatiom = Location.new
  end
end
