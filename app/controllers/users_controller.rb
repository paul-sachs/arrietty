include Geokit::Geocoders

class UsersController < ApplicationController
  def preferences
    @user = current_user
  end
  
  def update
    @user = current_user  
  end
end
