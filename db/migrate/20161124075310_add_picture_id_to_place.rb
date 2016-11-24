class AddPictureIdToPlace < ActiveRecord::Migration
  def change
    add_column :places, :picture_id, :integer
  end
end
