class AddMailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mail, :text
  end
end
