
include Geokit::Geocoders

class PreferencesController < ApplicationController
  def show
    @user = current_user
  end
  
  def update
    respond_to do |format|
      format.html do
         current_user.preference.update(preference_params)
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
        render json: {"address" => GoogleGeocoder.reverse_geocode(position_string).full_address}
      }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def preference_params
      params.require(:preference).permit(:about_me, :notification_message, :notification_interest)
    end
end