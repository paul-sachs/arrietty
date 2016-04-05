class AddUserImage < ActiveRecord::Migration
  def change
  	add_attachment :preferences, :image
  end
end
