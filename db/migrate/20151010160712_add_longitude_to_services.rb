class AddLongitudeToServices < ActiveRecord::Migration
  def change
    add_column :services, :longitude, :string
  end
end
