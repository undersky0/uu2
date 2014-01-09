class Group < ActiveRecord::Base
  acts_as_authorization_object
  
  attr_accessible :image_attributes, :name, :location_id, :location_name, :scribble_attributes, :group_type, :privacy, :about, :membership_id, :event_id, :headline
  
  has_many :users, :through => :memberships
  
  has_many :memberships
  
  has_one :location
  
  has_many :scribbles, :as => :scribbled
  accepts_nested_attributes_for :scribbles
  
  has_many :galleries, :as => :gallerable, :dependent => :destroy
  accepts_nested_attributes_for :galleries

  has_many :albums, :as => :albumable, :dependent => :destroy
  accepts_nested_attributes_for :albums

end
