class ChangeDefaultCurrentSizeToUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :current_size, :integer, default: 0
  end
end
