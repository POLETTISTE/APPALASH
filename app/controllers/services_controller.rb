# frozen_string_literal: true

class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy]

  # GET /services/new
  def new
    @service= Service.new
  end

  # GET /services
  def index
    @services = Service.all
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

  # POST /services
  def create
    @service= Service.new(service_params)

    if @service.save
      respond_to do |format|
        format.html { redirect_to @service, alert: 'service enregistrée' }
        format.json { render json: @service, status: :created, location: @service}
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  def update
    if @service.update(service_params)
      respond_to do |format|
        format.html { redirect_to @service, alert: 'service enregistrée' }
        format.json { render json: @service, status: :ok, location: @service}
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, alert: 'service supprimée' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service= Service.find(params[:id])
    return if @service

    redirect_to services_url, alert: 'service introuvable'
  end

  # Only allow a list of trusted parameters through.
  def service_params
    params.require(:service).permit(:name, :price)
  end
end
