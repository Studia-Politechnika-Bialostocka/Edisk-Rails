class AddOneAttributeForCreationFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :edisk_files, :ed_id, :integer
  end
end
