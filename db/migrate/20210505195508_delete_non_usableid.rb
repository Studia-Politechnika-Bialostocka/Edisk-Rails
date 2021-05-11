class DeleteNonUsableid < ActiveRecord::Migration[6.1]
  def change
    remove_column :edisk_files, :ediskdirectory_id, :integer
  end
end
