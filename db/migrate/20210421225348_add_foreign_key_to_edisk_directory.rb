class AddForeignKeyToEdiskDirectory < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :edisk_directories, :users
  end
end
