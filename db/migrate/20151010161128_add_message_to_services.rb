class AddMessageToServices < ActiveRecord::Migration
  def change
    add_column :services, :message, :string
  end
end
