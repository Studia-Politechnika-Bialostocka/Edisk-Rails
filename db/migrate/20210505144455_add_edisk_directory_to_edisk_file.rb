class AddEdiskDirectoryToEdiskFile < ActiveRecord::Migration[6.1]
  def change
    add_reference :edisk_files, :edisk_directory
  end
end
