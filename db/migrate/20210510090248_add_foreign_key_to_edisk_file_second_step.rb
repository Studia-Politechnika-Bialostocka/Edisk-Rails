class AddForeignKeyToEdiskFileSecondStep < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :edisk_files, :edisk_directories
  end
end
