class Adduseridtoediskfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :edisk_files, :userID, :integer
    remove_column :edisk_files, :user_id, :integer
  end
end
