class AddNewDefautlValueToEdiskDirectory < ActiveRecord::Migration[6.1]
  def change
    change_column_default :edisk_directories, :path, from:"/~",  to:"home"
  end
end
