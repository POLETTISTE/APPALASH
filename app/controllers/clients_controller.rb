class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  # GET /clients/new
  def new
    @client = Client.new
    @client.build_lash
    @client.build_extension
    @client.build_health
    authorize @client
    @clients = policy_scope(Client)
  end

  # POST /clients
  def create
    @client = Client.new(client_params)
    @client.user = current_user
    authorize @client
    @clients = policy_scope(Client)

    if @client.save
      alert_message = t('clients.create.success', firstname: @client.firstname, name: @client.name)
      respond_to do |format|
        format.html { redirect_to @client, alert: alert_message }
        format.json { render json: @client, status: :created, location: @client }
      end
    else
      alert_error_message = t('clients.create.error')
      respond_to do |format|
        format.html { render :new, alert: alert_error_message, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /clients
  def index
    @clients = policy_scope(Client).order('UPPER(name)')
    authorize @clients
    @users = current_user.admin? ? User.all : []

    if params[:query].present?
      search_results = Client.search_by_general_informations(params[:query])
      @clients = current_user.admin? ? search_results : search_results.where(user: current_user)
    end

    respond_to do |format|
      format.html
      format.json do
        if current_user.admin?
          render json: { users: @users, clients: @clients }
        else
          render json: { clients: @clients }
        end
      end
      format.text { render partial: 'clients/index_list', locals: { clients: @clients }, formats: [:html] }
    end
  end

  # GET /clients/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client.build_lash unless @client.lash
    @client.build_extension unless @client.extension
    @client.build_health unless @client.health
  end

  # PATCH/PUT /clients/1
  def update
    ensure_fields_exist
    if params[:client][:photo].present?
      @client.photo.attach(params[:client][:photo]) # Attach photo if present
    end

    if @client.update(client_params)
      alert_message = t('clients.update.success', firstname: @client.firstname, name: @client.name)
      respond_to do |format|
        format.html { redirect_to @client, alert: alert_message }
        format.text { render partial: 'clients/client_infos', locals: { client: @client }, formats: [:html] }
        format.json { render json: @client, status: :ok, location: @client }
      end
    else
      alert_error_message = t('clients.update.error')
      respond_to do |format|
        format.html { render :edit, alert: alert_error_message, status: :unprocessable_entity }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  def destroy
    @client.photo.purge if @client.photo.attached?
    @client.destroy
    respond_to do |format|
      alert_message = t('clients.destroy.success', firstname: @client.firstname, name: @client.name)

      format.html { redirect_to clients_url, alert: alert_message }
      format.json { head :no_content }
    end
  end

  private

  def set_client
    @client = Client.find(params[:id])
    authorize @client
    @clients = policy_scope(Client)
  rescue ActiveRecord::RecordNotFound
    alert_error_message = t('.not_found')
    redirect_to clients_url, alert: alert_error_message unless @client
  end

  def client_params
    params.require(:client).permit(
      :photo, :name, :firstname, :email, :phone, :address, :zip_code, :city, :country,
      :birthdate, :how_do_you_know_us, :notes,
      lash_attributes: %i[
        desired_effect face_diagnostic asymmetry_diagnostic
        eyelid_morphology_diagnostic alignment_morphology_diagnostic
        proportion_morphology_diagnostic thickness_diagnostic
        length_diagnostic curvature_diagnostic style
        notes mapping event texture density
      ],
      extension_attributes: %i[
        brand curvature
        thickness glue
      ],
      health_attributes: %i[
        diabetes pregnancy dry_eyes teary_eyes
        allergy contact_lenses surgery chemotherapy
        eyes_allergy itch first_application lie_down
        notes
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
end