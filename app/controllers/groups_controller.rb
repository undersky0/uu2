class GroupsController < ApplicationController
  before_filter :loadscribbles
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @groupscribbles = Scribble.where(:scribbled_id => @group, :scribbled_type => "Group")
    @albumable = @group
    @albums = @albumable.albums
    @album = Album.new
  end

  def new
    @group = Group.new
  end

  def create
    
    @group = Group.new(params[:group])
    if @group.save
      redirect_to @group, :notice => "Successfully created group."
    else
      render :action => 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      redirect_to @group, :notice  => "Successfully updated group."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_url, :notice => "Successfully destroyed group."
  end
  
   def newgroupscribble
    @group = Group.find(params[:id])
    @user = current_user
    @newgroupscribble = @group.scribbles.create(params[:scribble])
    redirect_to @group
    #@localscribble.scribbled = @user
    #@localscribble.scribbled = @localfeed
  end
  
    def loadscribbles
    if params[:group_id]
      @group = Group.find(params[:group_id])
    end
  end

end
