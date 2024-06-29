# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy]

  # GET /services/new
  def new
    @service = Service.new
    authorize @service
    @services = policy_scope(Service)
  end


  # POST /services
  def create
    @service = Service.new(service_params)
    @service.user = current_user
    authorize @service
    @services = policy_scope(Service)

    if @service.save
      alert_message = t('services.create.success', name: @service.name)

      respond_to do |format|
        format.html { redirect_to services_url, alert: alert_message }
        format.json { render json: @service, status: :created, location: @service }
      end
    else
      alert_error_message = t('services.create.error')
      respond_to do |format|
        format.html { render :new,  alert: alert_error_message,status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /services
  def index
    @services = policy_scope(Service.all)
    authorize @services

    respond_to do |format|
      format.html
      format.json { render json: @services }
    end
  end

  # GET /services/1
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit; end


  # PATCH/PUT /services/1
  def update
    ensure_fields_exist
    if @service.update(service_params)
      alert_message = t('services.update.success', name: @service.name)

      respond_to do |format|
        format.html { redirect_to @service,  alert: alert_message}
        format.json { render json: @service, status: :ok, location: @service }
      end
    else
      alert_error_message = t('serrvices.update.error')

      respond_to do |format|
        format.html { render :edit, alert: alert_error_message,status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    respond_to do |format|
      alert_message = t('services.destroy.success', name: @service.name)

      format.html { redirect_to services_url, alert: alert_message }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
    authorize @service
    @services = policy_scope(Service)
  rescue ActiveRecord::RecordNotFound
    alert_error_message = t('.not_found')
    redirect_to services_url, alert: alert_error_message unless @service
  end

  # Only allow a list of trusted parameters through.
  def service_params
    params.require(:service).permit(:name, :price)
  end

  def ensure_fields_exist
    service_params.each_key do |field|
      next if @service.respond_to?(field)

      add_field_to_schema(field)
    end
  end

  def add_field_to_schema(field)
    field_type = Service.columns_hash[field.to_s]&.type || :string
    @service.class.connection.add_column(@service.class.table_name, field, field_type)
    @service.class.reset_column_information
  end

  def perform_update
    if @service.update(service_params)
      render json: @service
    else
      render json: { errors: @service.errors }, status: :unprocessable_entity
    end
  end
end
