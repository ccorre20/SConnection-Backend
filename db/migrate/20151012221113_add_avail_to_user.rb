class AddAvailToUser < ActiveRecord::Migration
  def change
    add_column :users, :avail, :string
  end
end
