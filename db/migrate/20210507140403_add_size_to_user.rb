class AddSizeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :ediskSize, :bigint
    add_column :edisk_files, :userID, :integer
  end
end
