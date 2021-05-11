class AddNewDefaultValueToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :ediskSize,11000000
  end
end
