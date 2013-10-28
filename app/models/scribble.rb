class Scribble < ActiveRecord::Base
  attr_accessible :post, :posted_by, :posted_by_uid
  belongs_to :user,
  :foreign_key => "actor_id"
  
  has_many :comments, :as => :commentable
  
end
