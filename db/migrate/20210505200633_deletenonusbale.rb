class Deletenonusbale < ActiveRecord::Migration[6.1]
  def change
    remove_column :edisk_files, :edisk_Directory_id, :integer
  end
end
