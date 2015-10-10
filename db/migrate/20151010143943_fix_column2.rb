class FixColumn2 < ActiveRecord::Migration
  def change
    rename_column :users, :type, :user_t
  end
end
