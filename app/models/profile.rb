class Profile < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :age, :website, :phoneNo
end
