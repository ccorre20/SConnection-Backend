class AddUserokToServiceStatus < ActiveRecord::Migration
  def change
    add_column :service_statuses, :userok, :boolean
  end
end
