class AddOneAttribute < ActiveRecord::Migration[6.1]
  def change
    add_column :edisk_files, :edisk_directory_id, :integer
  end
end
