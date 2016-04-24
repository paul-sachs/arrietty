class AddLatAndLngToUserLocation < ActiveRecord::Migration
  def up
    add_column :user_locations, :lat, :decimal
    add_column :user_locations, :lng, :decimal
  end
  
  def down
    remove_column :user_locations, :lat
    remove_column :user_locations, :lng
  end
end
