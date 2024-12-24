module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :check_admin_limit, only: [:create]

    # Override the update action to handle the avatar update
    def update
      # Check if the user is trying to update their avatar
      if params[:user][:avatar].present?
        # If the user already has an avatar, delete the old one from Cloudinary
        if current_user.avatar.attached?
          old_public_id = current_user.avatar.blob.metadata['public_id']
          Cloudinary::Uploader.destroy(old_public_id) if old_public_id.present?
        end

        # Attach the new avatar if provided
        current_user.avatar.attach(params[:user][:avatar])
      end

      # Proceed with the regular Devise update process
      super
    end

    # Override the destroy action to handle avatar deletion
    def destroy
      # Check if the user has an avatar attached
      if current_user.avatar.attached?
        old_public_id = current_user.avatar.blob.metadata['public_id']
        Cloudinary::Uploader.destroy(old_public_id) if old_public_id.present?
      end

      # Proceed with the regular Devise destroy process (delete user)
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
