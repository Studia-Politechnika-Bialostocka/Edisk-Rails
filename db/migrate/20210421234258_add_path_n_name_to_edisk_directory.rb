class AddPathNNameToEdiskDirectory < ActiveRecord::Migration[6.1]
  def change
    add_column :edisk_directories, :PathNName, :string

  end
end
