# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def new
    @transaction = Transaction.new
    @clients = Client.all
    @services = Service.all
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user

    if @transaction.save
      respond_to do |format|
        format.html { redirect_to transactions_url, alert: 'Transaction was successfully created.' }
        format.json { render json: @transaction, status: :created, location: @transaction }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @transactions = Transaction.order(date: :desc, created_at: :desc).all
    @transactions_total_price = @transactions.sum(:total_price)

    respond_to do |format|
      format.html
      format.json { render json: @transactions }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  # DELETE /services/1
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, alert: 'transaction supprimée' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:date, :client_id, services: %i[name price])
  end
end
