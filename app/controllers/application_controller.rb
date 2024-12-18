# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, unless: :skip_pundit?

  around_action :switch_locale

  def switch_locale(&action)
    # Check if the locale is set in the params, cookies, or use the default locale
    locale = cookies[:user_locale] || params[:locale] || I18n.default_locale
    
    # If a locale is provided in the parameters, update the cookie
    if params[:locale] && params[:locale] != cookies[:user_locale]
      cookies[:user_locale] = { value: params[:locale], expires: 1.year.from_now }
      locale = params[:locale]
    end

    I18n.with_locale(locale, &action)
  end

  def switch_language
    # Simply redirect back to the referring page
    redirect_back(fallback_location: root_path)
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :firstname, :website])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :firstname, :website, :avatar])
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ || params[:action] == 'switch_language'
  end
end
