class Scribble < ActiveRecord::Base
  attr_accessible :post, :comments_attributes
  belongs_to :user,
  :foreign_key => 'actor_id'
  
  has_many :comments, :as => :commentable
  accepts_nested_attributes_for :comments
  

end
