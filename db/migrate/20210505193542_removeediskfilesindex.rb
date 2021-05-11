class Removeediskfilesindex < ActiveRecord::Migration[6.1]
  def change
    remove_index :edisk_files, :name
    remove_reference :edisk_files, :edisk_directory

  end
end
