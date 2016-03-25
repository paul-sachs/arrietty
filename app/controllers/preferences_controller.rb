include Geokit::Geocoders

class PreferencesController < ApplicationController
  def show
    @user = current_user
  end
  
  def update
    respond_to do |format|
      format.json {
        position = params[:position][:coords]
        latitude = position[:latitude]
        longitude = position[:longitude]
        position_string = "#{latitude},#{longitude}"
        render json: {"address" => GoogleGeocoder.reverse_geocode(position_string).full_address}
      }
    end
  end
end
