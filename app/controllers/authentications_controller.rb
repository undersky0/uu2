class AuthenticationsController < ApplicationController
  
    def index
    @authentications = current_user.authentications.all
  end
  def show
    @authentications = current_user.authentications.all
  end
  def home
  end
  def twitter
  omni = request.env["omniauth.auth"]
  
  authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

  if authentication
  flash[:notice] = "Logged in Successfully"
  sign_in_and_redirect user_path('1')
  
  elsif current_user
    token = omni['credentials'].token
    token_secret = omni['credentials'].secret
 
    current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
    flash[:notice] = "Authentication successful."
    sign_in_and_redirect user_path('2')
  
  else
     user = User.new
     user.apply_omniauth(omni)
     
    if user.save
     flash[:notice] = "Logged in."
     sign_in_and_redirect user_path('2')
   else
     session[:omniauth] = omni.except('extra')
     redirect_to new_user_registration_path
   end
  end
  

def facebook
      omni = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])
      
      if authentication # already have auth before.
      flash[:notice] = "Logged in Successfully"
      sign_in_and_redirect User.find(authentication.user_id)
      elsif current_user # current logging user but still don't have auth before.
      token = omni['credentials'].token
      token_secret = ""
      
      current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
      
      flash[:notice] = "Authentication successful."
      sign_in_and_redirect current_user
      
      else
      user = User.find_by_email(omni['extra']['raw_info'].email)
      if user.nil?
      user = User.new
      user.profile.firstname = omni['extra']['raw_info'].name
      user.email = omni['extra']['raw_info'].email
      
      user.apply_omniauth(omni)
      
      if user.save
      flash[:notice] = "Logged in."
      sign_in_and_redirect User.find('3')
      else
      session[:omniauth] = omni.except('extra')
      redirect_to new_user_registration_path
      end
      else # old user but not logging now
      token = omni['credentials'].token
      token_secret = ""
      
      user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
      
      flash[:notice] = "Authentication successful."
      sign_in_and_redirect user
      end
  end
end
  
  
  end
  
     def destroy
     @authentication = Authentication.find(params[:id])
     @authentication.destroy
     redirect_to authentications_url, :notice => "Successfully destroyed authentication."
   end
end
  
  
  
  
  
  def failure
redirect_to back, :flash => {:error => "Could not log you in. #{params[:message]}"}
end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # def create
  # auth = request.env["omniauth.auth"]
#  
  # # Try to find authentication first
  # authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
#  
  # if authentication
    # # Authentication found, sign the user in.
    # flash[:notice] = "Signed in successfully."
    # sign_in_and_redirect(:user, authentication.user)
  # else
    # # Authentication not found, thus a new user.
    # user = User.new
    # user.apply_omniauth(auth)
    # if user.save(:validate => false)
      # flash[:notice] = "Account created and signed in successfully."
      # sign_in_and_redirect(:user, user)
    # else
      # flash[:error] = "Error while creating a user account. Please try again."
      # redirect_to root_url
    # end
  # end
  # end
