class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments
  end
  
  def new
    @comment = @commentable.comments.new
  end
  
  
  
  
    def create
    @comment = @commentable.comments.new(params[:comment])
    if @comment.save
      format.html { redirect_to root_path }
      format.json { render :json => @comment, :status => :created, :location => @comment }
      #redirect_to @commentable, notice: "Comment created."
    else
      format.html { redirect_to root_path }
      format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      #render :new
    end
  end
  
  private

  def load_commentable
    klass = [Scribble].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end
  
end
