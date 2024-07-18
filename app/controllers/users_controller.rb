# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  after_action :verify_authorized, only: %i[edit update]
  layout 'website', only: [:show]

  def show
    @user = find_user_by_website

    if @user
      authorize @user # Ensure authorization is performed
      # Continue with action logic for authorized user
    else
      redirect_to errors_not_found_path
    end
  rescue Pundit::NotAuthorizedError
    redirect_to errors_not_found_path
  end

  def edit
    @user = find_user_by_website

    if @user
      authorize @user
    else
      redirect_to errors_not_found_path
    end
  rescue Pundit::NotAuthorizedError
    redirect_to root_path
  end

  def update
    @user = find_user_by_website

    if @user
      authorize @user

      # Check if there's already a user with the updated website
      if user_params[:website].present? && user_params[:website] != @user.website
        existing_user = User.find_by(website: user_params[:website])
        if existing_user && existing_user != @user
          flash[:alert] = 'Website already exists'
          redirect_to edit_user_profile_path(@user.website)
          return
        end
      end

      if @user.update(user_params)
        redirect_to user_profile_path(@user.website), notice: 'Profile updated successfully.'
      else
        render :edit
      end
    else
      redirect_to errors_not_found_path
    end
  rescue Pundit::NotAuthorizedError
    redirect_to root_path
  end

  private

  def find_user_by_website
    policy_scope(User).find_by(website: params[:website])
  end

  def user_params
    params.require(:user).permit(:website, :other_attributes)
  end
end
