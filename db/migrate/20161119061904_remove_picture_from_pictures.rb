class RemovePictureFromPictures < ActiveRecord::Migration
  def change
    remove_column :pictures, :picture, :text
  end
end
