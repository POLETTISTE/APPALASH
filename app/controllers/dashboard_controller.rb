# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    @clients = policy_scope(Client.all)
    @services = policy_scope(Service.all)
    @transactions = policy_scope(Transaction.all)

    authorize @clients
    authorize @services
    authorize @transactions

    @clients_group_by_name = @clients.group(:name).count
    @clients_how_do_you_know_us = @clients.group(:how_do_you_know_us).count

    # Respond with JSON for client counts
    respond_to do |format|
      format.html
      format.json do
        render json: { client_counts: @clients_group_by_name,
                       client_know_us: @clients_how_do_you_know_us,
                       clients: @clients }
      end
    end
  end
end
