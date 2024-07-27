class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  after_action :verify_authorized, only: %i[edit update]
  layout 'website', only: [:show]

  def show_website
    @services = policy_scope(Service.all)

    @user = find_user_by_website

    if @user
      authorize @user
    else
      redirect_to errors_not_found_path
    end
  rescue Pundit::NotAuthorizedError
    redirect_to errors_not_found_path
  end

  def edit_website
    @user = find_user_by_website

    if @user
      authorize @user
    else
      redirect_to errors_not_found_path
    end
  rescue Pundit::NotAuthorizedError
    redirect_to root_path
  end

  def update_website
    @user = find_user_by_website

    if @user
      authorize @user

      if user_params[:website].present? && user_params[:website] != @user.website
        existing_user = User.find_by(website: user_params[:website])
        if existing_user && existing_user != @user
          flash[:alert] = "Website '#{existing_user.website}' already exists"
          redirect_to edit_user_profile_path(@user.website)
          return
        end
      end

      if @user.update(user_params)
        redirect_to user_profile_path(@user.website), notice: 'Profile updated successfully.'
      else
        render :edit_website
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
