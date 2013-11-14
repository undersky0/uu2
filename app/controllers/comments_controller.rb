class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def index
    @commentable = load_commentable
    @comments = @commentable.comments(:all, :order => 'comments.created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @comments }
    end
  end
  
  def new
    @comment = @commentable.comments.new  
  end
  
    def create
    @user = current_user
    @commentable = load_commentable
    @scribble = Scribble.find_by_id(params[:scribble_id])
    @comment = @scribble.comments.create!(params[:comment])

    #@comment.commentable = @user
    #@comment.commentable = @scribble
    #@commentable = load_commentable
    #@comment = @scribble.comments.create(params[:comment])
    #@comment = @commentable.comments.create!(params[:comment])
    
    #@comment = @commentable.comments.new(params[:comment])
    #@comment.content = params[:content]
    
    # @comment.user_id = current_user.id
    # @user.comment = @comment
    if @comment.save
      respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render :json => @comment, :status => :created, :location => @comment }
      #redirect_to @commentable, notice: "Comment created."
      end
    else
      format.html { redirect_to root_path }
      format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      #render :new
    end
    
  end
  
  private

  def load_commentable
    if params[:scribble_id]
      @commentable = Scribble.find(params[:scribble_id])
    end
    
    # klass = [Scribble].detect { |c| params["#{c.name.underscore}_id"] }
    # @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end
  
end
