class RemoveParentIdFromEdiskDirectories < ActiveRecord::Migration[6.1]
  def change
    remove_column :edisk_directories, :parent_id, :integer
    remove_column :edisk_directories, :PathNName, :string

  end
end
