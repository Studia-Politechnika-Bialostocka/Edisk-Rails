class RemoveUserIdFromDatabase < ActiveRecord::Migration[6.1]
  def change
    remove_column :edisk_files, :userID, :integer

  end
end
