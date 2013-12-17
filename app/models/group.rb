class Group < ActiveRecord::Base
  acts_as_authorization_object
  
  attr_accessible :name, :location_id, :location_name, :scribble_attributes, :group_type, :privacy, :about, :membership_id, :event_id, :headline
  
has_many :users, :through => :memberships
has_many :memberships
has_one :location
  has_many :scribbles, :as => :scribbled
  accepts_nested_attributes_for :scribbles



end
