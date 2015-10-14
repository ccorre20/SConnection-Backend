class AddSTToServices < ActiveRecord::Migration
  def change
    add_column :services, :s_t, :string
  end
end
