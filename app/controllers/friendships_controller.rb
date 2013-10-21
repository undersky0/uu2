class FriendshipsController < ApplicationController
  
  def request
    @user = current_user
    @friend = User.find_by_actor_id(params[:actor_id])
    unless @friend.nil?
      if Friendships.request(@user, @friend)
        flash[:notice] = "friend request sent"
      else
        flash[:notice] = "friend request could not be sent"
      end
    end
    redirect_to :back
  end
  
  def accept
    @user = current_user
    @friend = User.find_by_actor_id(params[:actor_id])
    unless @friend.nil?
      if Friendships.accepted(@user, @friend)
        flash[:notice] = "friendship accepted"
      else
        flash[:notice] = "frienship error"
      end
      
    end
    redirect_to :back
  end
  
  def reject
    @user = current_user
    @friend = User.find_by_actor_id(params[:actor_id])
    unless @friend.nil?
      if Friendships.reject(@user, @friend)
        flash[:notice] = "friend request rejected"
      else
        flash[:notice] = "reject fail :)"
      end
    end
    redirect_to :back
  end
  
  
end
