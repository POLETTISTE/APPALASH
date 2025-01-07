class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit_website update_website]
  after_action :verify_authorized, only: %i[edit_website update_website]
  layout 'website', only: [:show_website]

  def index_personal_information
    # Eager-load the avatar attachment and blob for each user
    @user = policy_scope(User).includes(avatar_attachment: :blob).find(current_user.id)
    authorize @user
  end

  def show_website
    @user = find_user_by_website
    if @user
      # Eager-load the avatar for the user
      @user = @user.includes(avatar_attachment: :blob)
      authorize @user
    else
      redirect_to errors_not_found_path
    end
  end

  def edit_website
    @user = find_user_by_website
    if @user
      # Eager-load the avatar for the user
      @user = @user.includes(avatar_attachment: :blob)
      authorize @user
    else
      redirect_to errors_not_found_path
    end
  end

  def update_website
    @user = find_user_by_website
    return redirect_to errors_not_found_path unless @user

    authorize @user

    # Check if the website is forbidden ("appalash")
    if user_params[:website].downcase == 'appalash'
      return redirect_to edit_website_user_profile_path(@user.website), notice: 'The website name "appalash" is forbidden.'
    end

    # Check if the new website is unique
    if website_changed_to_existing?
      return redirect_to edit_website_user_profile_path(@user.website), notice: "Website '#{user_params[:website]}' is already taken."
    end

    # Update user profile if all validations pass
    if @user.update(user_params)
      redirect_to user_profile_path(@user.website), notice: 'Profile updated successfully.'
    else
      render :edit_website, notice: 'There was an error updating your profile.'
    end
  end

  private

  def find_user_by_website
    policy_scope(User).find_by(website: params[:website])
  end

  def user_params
    params.require(:user).permit(:website, :name, :firstname, :avatar) # Add avatar here if you want it to be updatable
  end

  def website_changed_to_existing?
    new_website = user_params[:website]
    new_website.present? && new_website != @user.website && User.exists?(website: new_website)
  end
end
