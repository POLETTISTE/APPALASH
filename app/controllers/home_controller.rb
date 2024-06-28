# app/controllers/home_controller.rb
class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[welcome offers]
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped


  def welcome
    # No authorization needed for welcome action
  end

  def offers
    # No authorization needed for offers action
  end
end
