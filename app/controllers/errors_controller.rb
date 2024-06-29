class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  def not_found
    render status: 404

  end

  def internal_server
    render status: 500

  end

  def unprocessable
    render status: 422

  end

  def unacceptable
    render status: 406

  end
end
