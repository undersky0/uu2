class Avatar < ActiveRecord::Base
  
  belongs_to :avatarable, :polymorphic => true
  attr_accessible :photo_content_type, :photo_file_name, :photo_file_size, :photo
  
  has_attached_file :photo,
  :styles => {
  :thumb=> "100x100#",
  :small  => "150x150>",
  :medium => "300x300>",
  :large =>   "400x400>" },
   :default_url => "/images/:style/default_avatar.png"
  validates_attachment_content_type :photo, :content_type => 'image/jpeg'
end
