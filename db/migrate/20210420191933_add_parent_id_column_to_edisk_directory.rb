class AddParentIdColumnToEdiskDirectory < ActiveRecord::Migration[6.1]
  def change
    add_column :edisk_directories, :parent_id, :integer
  end
end
