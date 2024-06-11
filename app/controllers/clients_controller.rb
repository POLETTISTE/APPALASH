class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]

  # GET /clients
  def index
    @clients = Client.all
  end

  # GET /clients/1
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: "Client was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      redirect_to @client, notice: "Client was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_url, notice: "Client was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.require(:client).permit(:name, :firstname, :email, :phone, :address, :zip_code, :city, :country, :birthdate, :how_do_you_know_us, :notes, :lash_desired_effect, :lash_face_diagnostic, :lash_asymmetry_diagnostic, :lash_eyelid_morphology_diagnostic, :lash_alignment_morphology_diagnostic, :lash_proportion_morphology_diagnostic, :lash_thickness_diagnostic, :lash_length_diagnostic, :lash_curvature_diagnostic, :lash_style, :lash_notes, :lash_mapping, :lash_event, :lash_texture, :lash_density, :lash_extensions_brand, :lash_extensions_curvature, :lash_extensions_thickness, :lash_extensions_glue, :lash_extensions_pretreatment_superbonder, :lash_extensions_pretreatment_booster, :health_diabetes, :health_pregnancy, :health_dry_eyes, :health_teary_eyes, :health_allergy, :health_contact_lenses, :health_surgery, :health_chemotherapy, :health_eyes_allergy, :health_itch, :health_first_application, :health_lie_down, :health_notes)
    end
end
