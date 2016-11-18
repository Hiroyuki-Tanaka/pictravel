class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.string  :season
      t.integer :month
      t.string  :time
      t.string  :theme
      t.text    :comment
      t.timestamps
    end
  end
end
