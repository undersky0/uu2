class MessagesController < ApplicationController

  
  def index
    mailbox = Mailbox.new(current_user)
    @inbox_messages = mailbox.inbox
  end
  
  
  def sent
    mailbox = Mailbox.new(current_user)
    @sent_messages = mailbox.outbox
  end
  
  def new
    @message = current_user.messages.new
  end
  
  def show
    message.read! if message.received? || message.unread?
    redirect_to edit_message_path(message) unless message.received? || message.sent?
  end

  
  def create
    @message = Message.new(message_params.merge(user: current_user))
    if @message.save
      send_message
    else
      render :new
    end
  end
  
  def reply
    @message = Message.find(params[:message_id])
    if params[:message][:body]
      @message.reply! message_params.merge(user: current_user)
      set_flash_message :notice, :replied
      redirect_to mailbox_path(:inbox)
    else
      set_flash_message :alert, :invalid
      redirect_to message
    end
  end
  
  def edit
    redirect_to message unless message.unsent?
  end 
  
   def edit
    redirect_to message unless message.unsent?
  end
  
    def trash
    @message = Message.find(params[:message_id])
    @message.trash!
    set_flash_message :notice, :trashed
    redirect_to mailbox_path(:inbox)
  end
  
    def destroy
    message.delete!
    set_flash_message :notice, :deleted
    redirect_to mailbox_path(:inbox)
  end
  
  private
  def message
    @message ||= Message.find(params[:id])
  end
  helper_method :message
  
  def message_params
    params.require(:message).permit(:body, :draft, recipient_ids: [])
  end
  
  def send_message
    message.send!
    notice = message.sent? ? set_flash_message(:notice, :sent) : set_flash_message(:notice, :saved)
    redirect_to mailbox_path(:inbox), notice: notice
  end
  
  def mailbox_name
    params[:mailbox] || message.mailbox.to_s
  end
  helper_method :mailbox_name

  def can_view_message
    unless mine?
      set_flash_message :notice, :unauthorised
      redirect_to mailbox_path(:inbox)
    end
  end
   
  def mine?
    message.user == current_user
  end
  # def new
    # @message = Message.new
    # if params[:replay_to]
      # @replay_to = User.find_by_actor_id(params[:replay_to])
      # unless @replay_to.nil?
        # @message.recepient_id = @replay_to.actor_id
      # end
    # end
  # end
  

  # def destroy_all
    # if params[:delete]
      # params[:delete].each { |id|}
      # @message = Message.find(id)
# 
    # end

  
  
  # private
  # def set_user
    # @user = current_user
  # end
#   
  
end
