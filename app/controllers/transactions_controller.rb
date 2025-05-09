# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]

  def new
    @transaction = Transaction.new
    @guests = policy_scope(Guest).order('UPPER(name)')
    @services = policy_scope(Service)
    @transactions = policy_scope(Transaction)
    authorize @guests
    authorize @transaction
    authorize @services

    return unless params[:query].present?

    search_results = Guest.search_by_general_informations(params[:query])
    @guests = current_user.admin? ? search_results : search_results.where(user: current_user)
  end

  def create
    # Use policy_scope to get the correct scope for transactions
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user

    # You can optionally use policy_scope to ensure the user has access to the guest and service
    @guests = policy_scope(Guest) # Scope the guests according to the policy
    @services = policy_scope(Service) # Scope the services according to the policy

    # Check if there are any services selected, then filter out any services with missing names or prices
    if params[:transaction][:services].present?
      filtered_services = params[:transaction][:services].select do |service|
        service[:name].present? && service[:price].present?
      end

      # Assign the filtered services to the transaction
      @transaction.services = filtered_services
    end

    # Authorize the transaction object itself
    authorize @transaction

    # Save the transaction and check for errors
    if @transaction.save
      alert_message = t('transactions.create.success', firstname: @transaction.guest.firstname,
                                                       name: @transaction.guest.name)

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
    @guests = policy_scope(Guest).includes(photo_attachment: :blob).order('UPPER(name)')
    @transactions = policy_scope(Transaction).order(date: :desc, created_at: :desc).all
    @transactions_total_price = @transactions.sum(:total_price)
    authorize @transactions

    # Automatically select the first transaction and redirect to its show page
    if @transactions.any?
      @selected_transaction = @transactions.first
      redirect_to @selected_transaction and return
    end

    respond_to do |format|
      format.html
      format.json { render json: @transactions }
    end
  end

  def show
    @transactions = policy_scope(Transaction).order(date: :desc, created_at: :desc).all
    @transactions_total_price = @transactions.sum(:total_price)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @guest = @transaction.guest
    from_guest = params[:from_guest] == 'true' # Check if the request came from the guest page

    if @transaction.destroy
      alert_message = t('transactions.destroy.success', firstname: @transaction.guest.firstname,
                                                        name: @transaction.guest.name)

      respond_to do |format|
        format.html do
          if from_guest
            # If from the guest page, redirect to guest show page with 'transactions' section
            redirect_to guest_path(@guest, selected_section: 'transactions'), alert: alert_message
          else
            # Otherwise, redirect to transactions index page
            redirect_to transactions_path, alert: alert_message
          end
        end
        format.json { head :no_content }
      end
    else
      alert_error_message = t('transactions.destroy.error')

      respond_to do |format|
        format.html { redirect_to guest_path(@guest), alert: alert_error_message }
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
    params.require(:transaction).permit(:date, :guest_id, services: %i[name price])
  end
end
