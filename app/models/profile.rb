class Profile < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  
  belongs_to :user
  attr_accessible :firstname, :lastname, :age, :website, :phoneNo

end
