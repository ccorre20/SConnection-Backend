class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.datetime :s_date
      t.integer :user_id
      t.integer :provider_id
      t.string :s_status

      t.timestamps null: false
    end
  end
end
