class User < ActiveRecord::Base
  
  include Scrubber
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :scribbles_attributes, :profile_attributes, :locations_attributes
  # attr_accessible :title, :body
  
  has_one :profile,
          :primary_key => 'actor_id',
          
          :autosave => true,
          dependent: :destroy
          # :primary_key => "profile_id",
          # :foreign_key => "profile_id"
          accepts_nested_attributes_for :profile
  
  has_many :scribbles, :primary_key => 'actor_id', dependent: :destroy
  accepts_nested_attributes_for :scribbles
  
  has_many :comments, :as => :commentable
  
  
  #user.places , location.places, user.locations
  has_many :locations, :through => :places, :primary_key => 'actor_id'
  has_many :places, :as => :locationable, :primary_key => 'actor_id'
  
  

  accepts_nested_attributes_for :locations
  
  # @user = User.find(params[:id]) # finds user
  # @commentable = @user # find the right link with commentable
  # @comments = @commentable.comments # finds the associated comments
  # @comment = Comment.new 
  
  before_save :create_actor_id  
  self.primary_key = 'actor_id'
  
  has_many :friendships, :primary_key =>'actor_id', :foreign_key => 'actor_id'
  has_many :friends,
           :through => :friendships,
           :conditions => "status  'accepted'",
           :order => :created_at
  
  
  has_many :requested_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'requested'",
           :order => :created_at
           
  has_many :pending_friends,
           :through => :friendships,
           :source => :friend,
           :conditions => "status = 'pending'",
           :order => :created_at
           
  # has_many :neighbours,
           # :through => :friendships,
           # :source => :friend,
           # :conditions => :location
           
  has_many :sent_messages,
           :class_name => 'Message',
           :primary_key => 'actor_id',
           :foreign_key => 'recepient_id',
           :order => "messages.created_at DESC"           
                   
  has_many :received_messages,
           :class_name => 'Message',
           :primary_key => 'actor_id',
           :foreign_key => 'recepient_id',
           :order => "messages.created_at DESC"        
    
    after_initialize :create_profile
           
  def unread_messages?
    unread_messages_count > 0 ? true : false
  end
     
           
  def create_actor_id
    begin
      self.actor_id = SecureRandom.base64(8)
    end while self.class.exists?(:actor_id => actor_id)
    end       
  

  
  def full_name
    @profile = self.profile
    return "#{@profile.firstname} #{@profile.lastname}"
  end
  
  def create_profile
    self.build_profile if self.profile.nil?
  end
           
           
           
end
