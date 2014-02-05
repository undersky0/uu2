class UsersController < ApplicationController
    # GET /users
  # GET /users.json

  def show
      @user = User.find(params[:id])
  end

  def showconnections
    flash[:notice]
    @user = User.find(params[:id])
    @all_connections = User.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes!(params[:avatar])
      redirect_to @user, :notice  => "Successfully updated profile."
    else
      render :action => 'index'
    end
  end
  
  def index
    
    @user = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
end
