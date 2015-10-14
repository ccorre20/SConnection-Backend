class AddLatitudeToServices < ActiveRecord::Migration
  def change
    add_column :services, :latitude, :string
  end
end
