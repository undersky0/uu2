class LocationsController < ApplicationController
  layout false
  # GET /locations
  # GET /locations.json
  def index
  @locations = Location.all
  @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
  marker.lat location.latitude
  marker.lng location.longitude
  end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    #@user = current_user
    #@location.places = @user
    #@user.locations << @location
       #@user.save 
    respond_to do |format|
      if @location.save
        # @location.places = @place
        # @location.user = @user
        # @location.save
        
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
  
  # def geocode_by
    # geocode_by :ip_address,
      # :latitude => :latitude, :longitude => :longitude
  # end
#   
  # def reverse_geocode_by
    # reverse_geocode_by :latitude, :longitude,
      # :address => :location
  # end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def location_params
      params.require(:location).permit(:address, :gmaps, :latitude, :longitude, :postcode)
    end
    
    
    
    
end
