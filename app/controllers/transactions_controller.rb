# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def new
    @transaction = Transaction.new
    @clients = policy_scope(Client).order('UPPER(name)')
    @services = policy_scope(Service)
    @transactions = policy_scope(Transaction)
    authorize @clients
    authorize @transaction
    authorize @services

    return unless params[:query].present?

    search_results = Client.search_by_general_informations(params[:query])
    @clients = current_user.admin? ? search_results : search_results.where(user: current_user)
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user
    authorize @transaction
    @transactions = policy_scope(Transaction)

    if @transaction.save
      alert_message = t('transactions.create.success', firstname: @transaction.client.firstname,
                                                       name: @transaction.client.name)

      respond_to do |format|
        format.html { redirect_to transactions_url, alert: alert_message }
        format.json { render json: @transaction, status: :created, location: @transaction }
      end
    else
      alert_error_message = t('transactions.create.error')

      respond_to do |format|
        format.html { render :new, alert: alert_error_message, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @clients = policy_scope(Client).includes(photo_attachment: :blob).order('UPPER(name)')
    @transactions = policy_scope(Transaction).order(date: :desc, created_at: :desc).all
    @transactions_total_price = @transactions.sum(:total_price)
    authorize @transactions

    respond_to do |format|
      format.html
      format.json { render json: @transactions }
    end
  end

  def show
    @transactions = policy_scope(Transaction).order(date: :desc, created_at: :desc).all
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  def destroy
    if @transaction.destroy
      alert_message = t('transactions.destroy.success', firstname: @transaction.client.firstname,
                                                        name: @transaction.client.name)

      respond_to do |format|
        format.html { redirect_to transactions_url, alert: alert_message }
        format.json { head :no_content }
      end
    else
      alert_error_message = t('transactions.destroy.error')

      respond_to do |format|
        format.html { redirect_to transactions_url, alert: alert_error_message }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
    authorize @transaction
    @transactions = policy_scope(Transaction)
  rescue ActiveRecord::RecordNotFound
    alert_error_message = t('.not_found')
    redirect_to transactions_url, alert: alert_error_message unless @transaction
  end

  def transaction_params
    params.require(:transaction).permit(:date, :client_id, services: %i[name price])
  end
end
