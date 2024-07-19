class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_admin_limit, only: [:create]

  private

  def check_admin_limit
    if user_params[:admin] == 'true' && User.where(admin: true).exists?
      flash[:alert] = 'There can only be one admin user.'
      redirect_to new_user_registration_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin, :website)
  end
end
