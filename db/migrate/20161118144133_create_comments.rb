class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer   :user_id
      t.integer   :picture_id
      t.integer   :rank
      t.text      :comment
      t.timestamps
    end
  end
end
