# frozen_string_literal: true

# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    @clients = Client.all
    @services = Service.all
    @transactions = Transaction.all
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
