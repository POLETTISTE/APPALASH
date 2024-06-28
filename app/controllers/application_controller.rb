# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :switch_locale
  before_action :authenticate_user!

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  # private

  # def set_layout
  #   self.class.layout layout_by_resource
  # end

  # def layout_by_resource
  #   if devise_controller? || home_controller?
  #     "home"
  #   else
  #     "application"
  #   end
  # end

  # def home_controller?
  #   is_a?(HomeController)
  # end
end
