# frozen_string_literal: true

class HomeController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home
  skip_before_action :authenticate_user!, only: %i[welcome offers]
  

  def welcome; end

  def offers; end
end
