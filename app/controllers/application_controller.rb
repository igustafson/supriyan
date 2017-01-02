class ApplicationController < ActionController::Base
#  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :select_subheading

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(display_name))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(display_name))
  end

  def select_subheading
    @subheading = Rails.configuration.subheadings['subheadings'].sample
  end

  before_action :store_current_location, unless: :devise_controller?
  helper_method :back_url

  private

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_out_path_for(resource)
    stored_location_for(:user) || root_path
  end

  def back_url
    session[:user_return_to] || root_path
  end
end
