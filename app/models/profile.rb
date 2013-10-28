class Profile < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  belongs_to :user,
  :foreign_key => "actor_id",
  :primary_key => "profile_id"
  
  attr_accessible :firstname, :lastname, :age, :website, :phoneNo, :profile_id
  
  before_save :create_profile_id
  
  
  
  private
    def create_profile_id
    begin
      self.profile_id = SecureRandom.base64(8)
    end while self.class.exists?(:profile_id => profile_id)
  end

end
