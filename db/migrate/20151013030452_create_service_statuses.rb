class CreateServiceStatuses < ActiveRecord::Migration
  def change
    create_table :service_statuses do |t|
      t.integer :service_id
      t.string :status

      t.timestamps null: false
    end
  end
end
