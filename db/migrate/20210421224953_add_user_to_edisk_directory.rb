class AddUserToEdiskDirectory < ActiveRecord::Migration[6.1]
  def change
    add_reference :edisk_directories, :user
  end
end
