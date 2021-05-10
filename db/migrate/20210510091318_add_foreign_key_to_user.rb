class AddForeignKeyToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :edisk_files, :user_id, :integer
    add_foreign_key :edisk_files, :users
  end
end
