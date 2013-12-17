class User < ActiveRecord::Base
  acts_as_authorization_subject  :association_name => :roles
  include Scrubber
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :avatar, :email, :password, :password_confirmation, :remember_me, :scribbles_attributes, :profile_attributes, :location_attributes
  # attr_accessible :title, :body
  
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "48x48>" }, :default_url => "/images/:style/missing.png"
  
  
  has_one :profile,
          dependent: :destroy
          accepts_nested_attributes_for :profile
  
  has_one :location, :primary_key => 'actor_id',
  dependent: :destroy
  accepts_nested_attributes_for :location
  
  
  has_many :scribbles, :as => :scribbled, dependent: :destroy
  accepts_nested_attributes_for :scribbles
  
  has_many :comments, :as => :commentable
  
  has_many :memberships, dependent: :destroy
  has_many :groups, :through => :memberships
  
  
  
  #user.places , location.places, user.locations
  # has_many :locations, :through => :places, :primary_key => 'user_id'
  # has_many :places, :as => :locationable, :primary_key => 'user_id'
#   
  

  # accepts_nested_attributes_for :locations
  
  # @user = User.find(params[:id]) # finds user
  # @commentable = @user # find the right link with commentable
  # @comments = @commentable.comments # finds the associated comments
  # @comment = Comment.new 
  
  before_save :create_actor_id  
  #self.primary_key = 'actor_id'
  
  
  has_many :friendship, :primary_key =>'actor_id', :foreign_key => 'actor_id'
  
  has_many :friends,
           :through => :friendship,
           :conditions => "status = 'accepted'",
           :order => :created_at
  
  
  has_many :requested_friends,
           :through => :friendship,
           :source => :friend,
           :conditions => "status = 'requested'",
           :order => :created_at
           
  has_many :pending_friends,
           :through => :friendship,
           :source => :friend,
           :conditions => "status = 'pending'",
           :order => :created_at
           
  # has_many :neighbours,
           # :through => :friendships,
           # :source => :friend,
           # :conditions => :location
           
has_many :messages, class_name: 'Message', foreign_key: 'user_id'    
    
    after_initialize :create_profile
    after_initialize :create_location
           
  def unread_messages?
    unread_messages_count > 0 ? true : false
  end
     
           
  def create_actor_id
    begin
      self.actor_id = SecureRandom.base64(8)
    end while self.class.exists?(:actor_id => actor_id)
    end       
  def prefix
    try(:full_name) || email
  end
def message_title
    "#{prefix} <#{email}>"
end

def mailbox
  mailbox.new(self)
end
  
  def full_name
    @profile = self.profile
    return "#{@profile.firstname} #{@profile.lastname}"
  end
  
  def create_profile
    self.build_profile() if self.profile.nil?
  end      
  def create_location
    self.build_location() if self.location.nil?
  end
  
  
  def joined?(group)
    self.memberships.find_by_group_id(group)
  end    
end
