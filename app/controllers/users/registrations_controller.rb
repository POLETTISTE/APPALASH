# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :check_admin_limit, only: [:create]

    # Override the update action to handle the avatar update
    def update
      # Check if the user is trying to update their avatar
      if params[:user][:avatar].present?
        # Allow avatar attachment if provided
        current_user.avatar.attach(params[:user][:avatar])
      end

      # Proceed with the regular Devise update process
      super
    end

    private

    def check_admin_limit
      return unless user_params[:admin] == 'true' && User.where(admin: true).exists?

      flash[:alert] = 'There can only be one admin user.'
      redirect_to new_user_registration_path
    end

    def user_params
      # Add :avatar to the permitted parameters for Devise
      params.require(:user).permit(:email, :password, :password_confirmation, :admin, :website, :avatar)
    end
  end
end
