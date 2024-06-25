# frozen_string_literal: true

# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    @clients = Client.all
    @prestations = Prestation.all
    @transactions = Transaction.all
    @clients_group_by_name = @clients.group(:name).count
    # Respond with JSON for client counts
    respond_to do |format|
      format.html
      format.json do
        render json: { client_counts: @clients_group_by_name, clients: @clients }
      end
    end
  end
end
