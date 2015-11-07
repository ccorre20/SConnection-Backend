class CreateProviderProfiles < ActiveRecord::Migration
  def change
    create_table :provider_profiles do |t|
      t.integer :provider_id
      t.string :description
      t.float :rating
      t.string :availability

      t.timestamps null: false
    end
  end
end
