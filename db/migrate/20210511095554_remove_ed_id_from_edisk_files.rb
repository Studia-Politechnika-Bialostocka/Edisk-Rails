class RemoveEdIdFromEdiskFiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :edisk_files, :ed_id, :integer
  end
end
