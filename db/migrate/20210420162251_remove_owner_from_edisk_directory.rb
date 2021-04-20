class RemoveOwnerFromEdiskDirectory < ActiveRecord::Migration[6.1]
  def change
    remove_column :edisk_directories, :owner, :string
  end
end
