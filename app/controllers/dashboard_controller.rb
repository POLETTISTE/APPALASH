# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @guests = policy_scope(Guest.all)
    @services = policy_scope(Service.all)
    @transactions = policy_scope(Transaction.all)
    @users = policy_scope(User.all)

    authorize @guests
    authorize @services
    authorize @transactions

    @non_admin_users = @users.reject(&:admin?) if current_user.admin?
    @admin_users = @users.select(&:admin?) if current_user.admin?

    @guests_group_by_name = @guests.group(:name).count
    @guests_how_do_you_know_us = @guests.group(:how_do_you_know_us).count

    # Respond with JSON for guest counts
    respond_to do |format|
      format.html
      format.json do
        response = {
          guest_counts: @guests_group_by_name,
          guest_know_us: @guests_how_do_you_know_us,
          guests: @guests
        }
        response[:users] = @users if current_user.admin?

        render json: response
      end
    end
  end
end
