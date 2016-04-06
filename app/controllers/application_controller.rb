class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  after_filter :flash_to_headers

  def after_sign_up_path_for(resource)
    preference_path
  end
  
  def flash_to_headers
    return unless request.xhr?
    key, value = flash.first
    if key
      response.headers['X-Message'] = value
      response.headers['X-Message-Type'] = key.to_s
    end
    # repeat for other flash types...
  
    flash.discard  # don't want the flash to appear when you reload page
  end
end
