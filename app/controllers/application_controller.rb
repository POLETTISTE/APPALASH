# frozen_string_literal: true

class ApplicationController < ActionController::Base
    rescue_from StandardError, with: :internal_server_error

  # Handle routing errors
  def not_found
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", status: :not_found }
      format.json { render json: { error: "Not Found" }, status: :not_found }
      format.all { render plain: "404 Not Found", status: :not_found }
    end
  end

  # Handle 500 errors
  def internal_server_error(exception)
    # Log the exception (optional)
    logger.error(exception.message)
    logger.error(exception.backtrace.join("\n"))

    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/500.html", status: :internal_server_error }
      format.json { render json: { error: "Internal Server Error" }, status: :internal_server_error }
      format.all { render plain: "500 Internal Server Error", status: :internal_server_error }
    end
  end
end
