class AddExpirationTimeToEdiskFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :edisk_files, :expiration_time, :string , default: "nil"
  end
end
