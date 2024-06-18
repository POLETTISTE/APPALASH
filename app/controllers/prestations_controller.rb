class PrestationsController < ApplicationController
  before_action :set_prestation, only: %i[show edit update destroy]

  # GET /prestations/new
  def new
    @prestation = Prestation.new
  end

  # GET /prestations
  def index
    @prestations = Prestation.all
    respond_to do |format|
      format.html
      format.json { render json: @prestations }
    end
  end

  # GET /prestations/1
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prestation }
    end
  end

  # GET /prestations/1/edit
  def edit
  end

  # POST /prestations
  def create
    @prestation = Prestation.new(prestation_params)

    if @prestation.save
      respond_to do |format|
        format.html { redirect_to @prestation, notice: 'Prestation enregistrée' }
        format.json { render json: @prestation, status: :created, location: @prestation }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prestation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prestations/1
  def update
    if @prestation.update(prestation_params)
      respond_to do |format|
        format.html { redirect_to @prestation, notice: 'Prestation enregistrée' }
        format.json { render json: @prestation, status: :ok, location: @prestation }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prestation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prestations/1
  def destroy
    @prestation.destroy
    respond_to do |format|
      format.html { redirect_to prestations_url, notice: 'Prestation supprimée' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prestation
    @prestation = Prestation.find_by(id: params[:id])
    unless @prestation
      redirect_to prestations_url, alert: 'Prestation introuvable'
    end
  end

  # Only allow a list of trusted parameters through.
  def prestation_params
    params.require(:prestation).permit(:name, :price)
  end
end
