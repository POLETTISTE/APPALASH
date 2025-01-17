# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @cguests = policy_scope(Guest.all)
    @services = policy_scope(Service.all)
    @transactions = policy_scope(Transaction.all)
    @users = policy_scope(User.all)

    authorize @cguests
    authorize @services
    authorize @transactions

    @non_admin_users = @users.reject(&:admin?) if current_user.admin?
    @admin_users = @users.select(&:admin?) if current_user.admin?

    @cguests_group_by_name = @cguests.group(:name).count
    @cguests_how_do_you_know_us = @cguests.group(:how_do_you_know_us).count

    # Respond with JSON for guest counts
    respond_to do |format|
      format.html
      format.json do
        response = {
          guest_counts: @cguests_group_by_name,
          guest_know_us: @cguests_how_do_you_know_us,
          guests: @cguests
        }
        response[:users] = @users if current_user.admin?

        render json: response
      end
    end
  end
end
