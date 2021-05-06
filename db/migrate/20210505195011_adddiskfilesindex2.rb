class Adddiskfilesindex2 < ActiveRecord::Migration[6.1]
  def change
    add_reference :edisk_files, :edisk_Directory
  end
end
