class NavigationController < ApplicationController
  before_filter :update_scribblestreams, :only => [:home, :refreshscribbles]
  
  
  def home

  end

  def feeds
  end
  
  def promote
  @scribble = Scribble.find(params[:id])
  @scribble.promotes=@scribble.promotes+1
  @scribble.save
  render :text => "<div class='up'></div>"+@scribble.promotes.to_s+" likes"
  end
 
  def demotes
  @scribble = Scribble.find(params[:id])
  @scribble.demotes=@scribble.demotes+1
  @scribble.save
  render :text => "<div class='down'></div>"+@scribble.demotes.to_s+" dislikes"
  end
 
  def refreshscribbles
  @scribble = Scribble.find(params[:id])
  @user = User.find_by_actor_id(scribble.actor_id)
  render :partial => 'scribbles.html.erb', :locals => { :scribbles_streams => @scribbles_streams }
  end
  
  def refreshcomments
    render :partial => 'comments.html.erb, :locals => {:comments_streams => @comments_streams}'
  end
  
  protected
  
  def update_comments
    @comments_streams = Comment.order('created_at DESC').all
  end
  
  def update_scribblestreams
  @scribbles_streams = Scribble.order('created_at DESC').all
  end 
 

 
end
