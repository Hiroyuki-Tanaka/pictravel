class RemovePictureFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatar, :text
  end
end
