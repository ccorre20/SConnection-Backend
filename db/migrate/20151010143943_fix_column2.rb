class FixColumn2 < ActiveRecord::Migration
  def change
    rename_column :users, :user_t, :user_t
  end
end
