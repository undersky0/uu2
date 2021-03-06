class Profile < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  
  belongs_to :user

  
  attr_accessible :firstname, :lastname, :age, :website, :phoneNo, :profile_id, :actor_id, :name
  
  before_save :create_profile_id
  self.primary_key = 'profile_id'
  
  
    def full_name
    @profile = self.profile
    return "#{@profile.firstname} #{@profile.lastname}"
    end
  
  def load_into_soulmate
    loader = Soulmate::Loader.new("profile")
    loader.add("term" => full_name, "id" => id)
  end
  
  
  private
    def create_profile_id
    begin
      self.profile_id = SecureRandom.base64(8)
    end while self.class.exists?(:profile_id => profile_id)
  end







end
