class AddProviderokToServiceStatus < ActiveRecord::Migration
  def change
    add_column :service_statuses, :providerok, :boolean
  end
end
