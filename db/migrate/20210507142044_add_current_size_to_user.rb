class AddCurrentSizeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :current_size, :bigint
  end
end
