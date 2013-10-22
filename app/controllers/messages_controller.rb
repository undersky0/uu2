class MessagesController < ApplicationController
  before_filter :set_user
  def index
    if params[:mailbox] == "sent"
      @messages = @user.sent_messages
    
  elsif params[:mailbox] == "inbox"
    @messages = @user.received_messages
    
    end
  end
  

  
  def create
    @message = Message.new(params[:message])
    @message.sender_id = @user.actor_id
    if @message.save
      flash[:notice] = "message sent"
    else
      reder :action => :new
    end
  end
  
  def new
    @message = Message.new
    if params[:replay_to]
      @replay_to = User.find_by_beamer_id(params[:replay_to])
      unless @replay_to.nil?
        @message.recepient_id = @replay_to.actor_id
      end
    end
  end
  
  def show
    @message = Message.readinmessage(params[:id], @user.actor_id)
  end
  
  def destroy_all
    if params[:delete]
      params[:delete].each { |id|}
      @message = Message.find(id)

    end
    
  end
  
  
  
  private
  def set_user
    @user = current_user
  end
  
  
end
