class AddPictureToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :picture, :text
  end
end
