class UsersController < ApplicationController
    # GET /users
  # GET /users.json
   layout false
  def show
      @user = User.find_by_actor_id(params[:id])
  end

  def showconnections
    flash[:notice]
    @user = User.find_by_actor_id(params[:actor_id])
    @all_connections=User.all
  end
  
  def index
    
    @user = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
end
