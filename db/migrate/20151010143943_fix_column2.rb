class FixColumn2 < ActiveRecord::Migration
  def change
    rename_column :users, :user_type, :user_t
  end
end
