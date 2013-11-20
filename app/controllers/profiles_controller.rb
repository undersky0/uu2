class ProfilesController < ApplicationController
  
  
  # before_filter :load_user
  def index
    @profiles = Profile.all
    @profile = profile.find_by_actor_id(current_user.actor_id)
  end

  def show
    #@profile = Profile.find(params[:id])
    @user = User.find_by_actor_id(current_user)
    #@user = current_user
    @profile = @user.profile
  end

  def new
    @user = current_user
    @user.profile.new
  end

  def create
    @user = current_user
    #@profile = Profile.new(profile_params)
    @user.profile.new(profile_params)
    #@user.profile.create(profile_params)

    #@profile = @user.profile
    @user.profile.actor_id = current_user.actor_id
    @user.profile_id = @user.profile.profile_id
    if @user.profile.save
      
      @user.profile.firstname = 'fuckyou'
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
  
  # def load_user
    # @user = current_user
  # end
end
