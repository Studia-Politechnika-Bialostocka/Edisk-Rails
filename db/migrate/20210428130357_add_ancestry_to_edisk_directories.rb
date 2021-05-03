class AddAncestryToEdiskDirectories < ActiveRecord::Migration[6.1]
  def change
    add_column :edisk_directories, :ancestry, :string
    add_index :edisk_directories, :ancestry
  end
end
