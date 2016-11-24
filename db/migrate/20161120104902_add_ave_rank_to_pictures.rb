class AddAveRankToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :ave_rank, :integer
  end
end
