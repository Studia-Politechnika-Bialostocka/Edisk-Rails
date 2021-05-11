class RemoveForeignKeyFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :edisk_files, :users
  end
end
