# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @clients = policy_scope(Client.all)
    @services = policy_scope(Service.all)
    @transactions = policy_scope(Transaction.all)
    @users = policy_scope(User.all)

    authorize @clients
    authorize @services
    authorize @transactions
    # authorize @users

    if current_user.admin?
    @non_admin_users = @users.reject(&:admin?)
    @admin_users = @users.select(&:admin?)

    end

    @clients_group_by_name = @clients.group(:name).count
    @clients_how_do_you_know_us = @clients.group(:how_do_you_know_us).count

    # Respond with JSON for client counts
    respond_to do |format|
      format.html
      format.json do
        response = {
          client_counts: @clients_group_by_name,
          client_know_us: @clients_how_do_you_know_us,
          clients: @clients
        }
        response[:users] = @users if current_user.admin?

        render json: response
      end
    end
  end
end
