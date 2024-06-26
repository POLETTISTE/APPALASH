# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  # GET clients/new
  def new
    @client = Client.new
  end

  # GET /clients
  def index
    @clients = Client.all.order('UPPER(name)')
    params[:query].present? && @clients = Client.search_by_general_informations(params[:query])
    respond_to do |format|
      format.html
      format.json { render json: Client.all }
      format.text { render partial: 'clients/list', locals: { clients: @clients }, formats: [:html] }
    end
  end

  # GET /clients/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @client }
    end
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      respond_to do |format|
        format.html { redirect_to @client, alert: "création réussie pour #{@client.firstname} #{@client.name}" }
        format.json { render json: @client, status: :created, location: @client }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  def update
    ensure_fields_exist
    if @client.update(client_params)
      respond_to do |format|
        format.html { redirect_to @client, alert: "modification réussie pour #{@client.firstname} #{@client.name}" }
        format.text { render partial: 'clients/client_infos', locals: { client: @client }, formats: [:html] }
        format.json { render json: @client, status: :ok, location: @client }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  def destroy
    @client.photo.purge if @client.photo.attached?
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, alert: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
    redirect_to clients_url, alert: 'Client not found' unless @client
  end

  def client_params
    params.require(:client).permit(
      :photo, :name, :firstname, :email, :phone, :address, :zip_code, :city, :country,
      :birthdate, :how_do_you_know_us, :notes,
      lash_attributes: %i[
        desired_effect face_diagnostic asymmetry_diagnostic
        eyelid_morphology_diagnostic alignment_morphology_diagnostic
        proportion_morphology_diagnostic thickness_diagnostic
        length_diagnostic curvature_diagnostic style notes
        mapping event texture density extensions_brand
        extensions_curvature extensions_thickness extensions_glue
        extensions_pretreatment_superbonder extensions_pretreatment_booster
      ],
      health_attributes: %i[
        diabetes pregnancy dry_eyes teary_eyes allergy contact_lenses
        surgery chemotherapy eyes_allergy itch first_application
        lie_down notes
      ]
    )
  end
  def ensure_fields_exist
    client_params.each_key do |field|
      next if @client.respond_to?(field)

      add_field_to_schema(field)
    end
  end

  def add_field_to_schema(field)
    field_type = Client.columns_hash[field.to_s]&.type || :string
    @client.class.connection.add_column(@client.class.table_name, field, field_type)
    @client.class.reset_column_information
  end

  def perform_update
    if @client.update(client_params)
      render json: @client
    else
      render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end
end
