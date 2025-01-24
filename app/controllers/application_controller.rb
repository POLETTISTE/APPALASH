class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, unless: :skip_pundit?

  # Ensure locale is set in URL options
  def default_url_options
    # Ensure the URL reflects the current locale, but omit it if it's the default (English)
    { locale: I18n.locale == I18n.default_locale ? 'en' : I18n.locale }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:remember_me])
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name firstname website language])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name firstname website avatar language])
  end

  private

  # Set locale based on user preferences, URL, cookies, or browser language
  def set_locale
    # 1. If the user is logged in and has a language preference, use that
    if user_signed_in? && I18n.available_locales.include?(current_user.language.try(:to_sym))
      I18n.locale = current_user.language
    # 2. If a language is specified in the URL, use it
    elsif params[:locale].present? && I18n.available_locales.include?(params[:locale].to_sym)
      I18n.locale = params[:locale]
      # Store the selected language in the cookie for future visits (only if the user is not logged in)
      cookies[:locale] = { value: params[:locale], expires: 1.year.from_now }
    # 3. If no URL parameter, use the language stored in the cookie (for non-logged-in users)
    elsif cookies[:locale].present? && I18n.available_locales.include?(cookies[:locale].to_sym)
      I18n.locale = cookies[:locale].to_sym
    # 4. If the user is not logged in and no cookie is present, default to English
    elsif !user_signed_in? && cookies[:locale].blank?
      I18n.locale = I18n.default_locale
      # Explicitly set the URL to '/en' for the default locale (English)
      request.env['PATH_INFO'] = '/en' # Ensures /en is in the URL path
    # 5. If the user has not explicitly set a language (first visit), detect the browser language
    elsif request.env['HTTP_ACCEPT_LANGUAGE'].present?
      detected_locale = extract_locale_from_accept_language_header || I18n.default_locale
      I18n.locale = detected_locale
      # Store the detected language in the cookie for future visits
      cookies[:locale] = { value: detected_locale, expires: 1.year.from_now }
    else
      # Default to the default locale (e.g., English)
      I18n.locale = I18n.default_locale
    end
  end

  # Extract the language from the browser's Accept-Language header
  def extract_locale_from_accept_language_header
    # Here we extract the first language code from the browser's Accept-Language header
    # e.g., 'en-US' => 'en'
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end

  # Change language based on the user's selection and store it in a cookie
  def change_language
    new_locale = params[:locale]

    # Validate the selected language and store it in the cookie if valid
    if I18n.available_locales.include?(new_locale.to_sym)
      cookies[:locale] = { value: new_locale, expires: 1.year.from_now }
    end

    # Redirect to the same page after language change
    redirect_to request.referer || root_path
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
