class CreateEdiskFiles < ActiveRecord::Migration[6.1]
  def change
    add_index :edisk_files, :name, unique: true
  end
end
