class LocalfeedsController < ApplicationController
  before_filter :loadscribbles
  def index
   
    @localfeeds = Localfeed.all
  respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @localfeeds }
    end
  end

  def show
    # @newlocalscribble = Scribble.new
    @localfeeds = Localfeed.all
     @localfeed = Localfeed.find(params[:id])
    # #@feed = loadscribbles
    # @feed = @localfeed.scribbles(:all, :order => 'scribbles.created_at DESC')
    # #@localfeeds = Localfeed.all
    # respond_to do |format|
      # format.html # index.html.erb
      # format.json { render :json => @feed }
    # end
    if @localfeed.nil?
      @localfeed = Localfeed.find_by_city(current_user.location.city)
    else
    @localscribbles = Scribble.where(:scribbled_id => @localfeed)
    end
    
      respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @localscribbles }
    end
  end

  def new
    @localfeed = Localfeed.new
    @feed = Localfeed.find_by_id(params[:localfeed])
  end

  def create
    @localfeed = Localfeed.new(params[:localfeed])
    if @localfeed.save
      redirect_to @localfeed, :notice => "Successfully created localfeed."
    else
      render :action => 'new'
    end
    

  end

  def edit
    @localfeed = Localfeed.find(params[:id])
  end

  def update
    @localfeed = Localfeed.find(params[:id])
    if @localfeed.update_attributes(params[:localfeed])
      redirect_to @localfeed, :notice  => "Successfully updated localfeed."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @localfeed = Localfeed.find(params[:id])
    @localfeed.destroy
    redirect_to localfeeds_url, :notice => "Successfully destroyed localfeed."
  end
  
  def loadscribbles
    if params[:localfeed_id]
      @localfeed = Localfeed.find(params[:localfeed_id])
    end
  end
  
  def newlocalscribble
    @localfeed = Localfeed.find(params[:id])
    @user = current_user
    @newlocalscribble = @localfeed.scribbles.create(params[:scribble])
    redirect_to @localfeed
    #@localscribble.scribbled = @user
    #@localscribble.scribbled = @localfeed
  end
end
