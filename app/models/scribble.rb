class Scribble < ActiveRecord::Base
  attr_accessible :post, :comments_attributes, :user_id, :posted_by, :localfeed_attributes
  belongs_to :scribbled, :polymorphic => true
  
  has_many :comments, :as => :commentable
  accepts_nested_attributes_for :comments
end
