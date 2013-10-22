class ProfilesController < ApplicationController
  # def index
    # @profiles = Profile.all
  # end

  def show
    #@profile = Profile.find(params[:id])
    @user = current_user
    @profile = current_user.profile
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to @profile, :notice => "Successfully created profile."
    else
      render :action => 'new'
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes!(person_params)
      redirect_to @profile, :notice  => "Successfully updated profile."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to profiles_url, :notice => "Successfully destroyed profile."
  end
  
  private
  def profile_params
    params.require(:profile).permit(:firstname, :lastname, :age, :website, :phoneNo)
  end
end
