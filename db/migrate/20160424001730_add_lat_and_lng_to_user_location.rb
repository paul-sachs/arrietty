class AddLatAndLngToUserLocation < ActiveRecord::Migration
  def up
    add_column :user_locations, :lat, :decimal
    add_column :user_locations, :lng, :decimal
    
    User.find_each do |user|
      UserLocation.create(lat: 43.6532, lng: -79.3832, user_id: user.id)
    end
  end
  
  def down
    remove_column :user_locations, :lat
    remove_column :user_locations, :lng
  end
end
