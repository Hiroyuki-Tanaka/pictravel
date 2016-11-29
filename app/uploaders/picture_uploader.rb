

class PictureUploader < CarrierWave::Uploader::Base

storage :fog

process :convert => 'png'

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end



end
