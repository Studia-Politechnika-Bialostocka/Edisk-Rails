class CreateEdiskDirectory < ActiveRecord::Migration[6.1]
  extend ActsAsTree::TreeView
  acts_as_tree order: "name"
  def change
    create_table :edisk_directories do |t|
      t.string :name
      t.string :path
      t.string :owner

      t.timestamps
    end
  end
end
