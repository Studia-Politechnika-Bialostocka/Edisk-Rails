class Removeediskfilesindex2 < ActiveRecord::Migration[6.1]
  def change
    remove_reference :edisk_files, :edisk_directory
  end
end
