
include Geokit::Geocoders

class PreferencesController < ApplicationController
  def show
    @user = current_user
  end
  
  def update
    lat = params[:latitude]
    lng = params[:longitude]
    current_user.user_location = UserLocation.create( lat: lat, lng: lng)
    current_user.preference.update(preference_params)

    respond_to do |format|
      format.html do
         @user = current_user
         render :show
      end
    end
  end

   def locate_me
    respond_to do |format|
      format.json {
        position = params[:position][:coords]
        latitude = position[:latitude]
        longitude = position[:longitude]
        position_string = "#{latitude},#{longitude}"
        location = GoogleGeocoder.reverse_geocode(position_string)
        render json: {
          "address" => location.full_address,
          "neighborhood" => location.neighborhood,
          "country" => location.country,
          "city" => location.city
        }
      }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      params.require(:preference).permit(:about_me, :notification_message, 
          :notification_interest, :image, :display_name, :location)
    end
end