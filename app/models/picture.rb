class Picture < ActiveRecord::Base

 mount_uploader :picture, PictureUploader


  belongs_to :user
  has_many :comments
  has_many :places
end
