class ScribblesController < ApplicationController
   # GET /scribbles
  # GET /scribbles.json
  def index
    @scribbles = Scribble.find(:all, :order => 'scribbles.created_at DESC')
    @scribble = scribble.new

      respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @scribbles }
    end
  end

  # GET /scribbles/1
  # GET /scribbles/1.json
  def show
    @scribble = Scribble.find(params[:id])
    @user = User.find_by_actor_id(current_user.actor_id)
    @profile = @user.profile
    @commentable = @scrible
    @comments = @commentable.comments
    @comment = Comment.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @scribble }
    end
  end

  # GET /scribbles/1/edit
  def edit
    @scribble = Scribble.find(params[:id])
  end
def new
  @user = current_user
  @scribble = @user.scribble.new
end
  # POST /scribbles
  # POST /scribbles.json
  def create
    @user = current_user
    @scribble = @user.scribbles.new(params[:scribble])
    
    @scribble.actor_id = @user.actor_id
    

    #@scribble.posted_by_uid=current_user.actor_id
    #@user = User.find_by_actor_id(current_user.actor_id)
    #@profile = @user.profile
    

    @scribble.posted_by= @user.full_name
    
    #t = @profile.user.firstname
    #@scribble.posted_by = t
    #current_user.profile 
    #@profile = Profile.current_user.id
    #@scribble.posted_by=@profile.first_name+" "+@profule.last_name
    #@scribble.posted_by=current_user.first_name+" "+current_user.last_name
    #@user.scribbles.promotes=0
    #@user.scribbles.demotes=0
   # @scribble.save
    #@user = current_user
    respond_to do |format|
      if @scribble.save
        #@user.scribbles = @scribble
        format.html { redirect_to root_path }
        format.json { render :json => @scribble, :status => :created, :location => @scribble }
      else
        format.html { redirect_to root_path }
        format.json { render :json => @scribble.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # PUT /scribbles/1
  # PUT /scribbles/1.json
  def update
    @scribble = Scribble.find(params[:id])

    respond_to do |format|
      if @scribble.update_attributes(params[:scribble])
        format.html { redirect_to @scribble, :notice => 'Scribble was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @scribble.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scribbles/1
  # DELETE /scribbles/1.json
  def destroy
    @scribble = Scribble.find(params[:id])
    @scribble.destroy

    respond_to do |format|
      format.html { redirect_to scribbles_url }
      format.json { head :no_content }
    end
  end
end