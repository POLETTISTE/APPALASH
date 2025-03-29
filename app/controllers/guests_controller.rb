# frozen_string_literal: true

class GuestsController < ApplicationController
  before_action :set_guest, only: %i[show edit update destroy]

  # GET /guests/new
  def new
    @guest = Guest.new
    @guest.build_lash
    @guest.build_extension
    @guest.build_health
    authorize @guest
    @guests = policy_scope(Guest)
  end

  # POST /guests
  def create
    @guest = Guest.new(guest_params)
    @guest.user = current_user
    authorize @guest
    @guests = policy_scope(Guest)

    if @guest.save
      alert_message = t('guests.create.success', firstname: @guest.firstname, name: @guest.name)
      respond_to do |format|
        format.html { redirect_to @guest, alert: alert_message }
        format.json { render json: guest_with_avatar_url([@guest]), status: :created, location: @guest }
      end
    else
      alert_error_message = t('guests.create.error')
      respond_to do |format|
        format.html { render :new, alert: alert_error_message, status: :unprocessable_entity }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /guests
  def index
    # Eager load the photo attachment and blob for each guest
    @guests = policy_scope(Guest).includes(photo_attachment: :blob).order('UPPER(name)')
    authorize @guests
    @users = current_user.admin? ? User.all : []

    if params[:query].present?
      search_results = Guest.search_by_general_informations(params[:query])
      @guests = current_user.admin? ? search_results : search_results.where(user: current_user)
    end

    respond_to do |format|
      format.html
      format.json do
        if current_user.admin?
          render json: { users: @users, guests: guest_with_avatar_url(@guests) }
        else
          render json: { guests: guest_with_avatar_url(@guests) }
        end
      end
      format.text { render partial: 'guests/index/guests_index_list', locals: { guests: @guests }, formats: [:html] }
    end
  end

  # GET /guests/1
  def show
    respond_to do |format|
      format.html
      format.json { render json: guest_with_avatar_url([@guest]).first }
    end
  end

  # GET /guests/1/edit
  def edit
    @guest.build_lash unless @guest.lash
    @guest.build_extension unless @guest.extension
    @guest.build_health unless @guest.health
  end

  # PATCH/PUT /guests/1
  def update
    ensure_fields_exist

    # If there's a new photo uploaded
    if params[:guest][:photo].present?
      # Delete the old photo from Cloudinary (if it exists)
      if @guest.photo.attached?
        # Get the public ID of the old image
        old_public_id = @guest.photo.blob.metadata['public_id']

        # Destroy the old image from Cloudinary
        Cloudinary::Uploader.destroy(old_public_id) if old_public_id.present?
      end

      # Attach the new photo
      @guest.photo.attach(params[:guest][:photo])
    end

    if @guest.update(guest_params)
      alert_message = t('guests.update.success', firstname: @guest.firstname, name: @guest.name)
      respond_to do |format|
        format.html { redirect_to @guest, alert: alert_message }
        format.text { render partial: 'guests/guest_infos', locals: { guest: @guest }, formats: [:html] }
        format.json { render json: guest_with_avatar_url([@guest]).first, status: :ok, location: @guest }
      end
    else
      alert_error_message = t('guests.update.error')
      respond_to do |format|
        format.html { render :edit, alert: alert_error_message, status: :unprocessable_entity }
        format.json { render json: @guest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guests/1
  def destroy
    # Check if a photo is attached to the guest
    if @guest.photo.attached?
      # Get the public_id of the attached photo
      old_public_id = @guest.photo.blob.metadata['public_id']

      # Destroy the photo from Cloudinary
      Cloudinary::Uploader.destroy(old_public_id) if old_public_id.present?
    end

    # Now destroy the guest record
    @guest.destroy

    respond_to do |format|
      alert_message = t('guests.destroy.success', firstname: @guest.firstname, name: @guest.name)
      format.html { redirect_to guests_url, alert: alert_message }
      format.json { head :no_content }
    end
  end

  private

  def set_guest
  # Eager load the photo attachment and blob, as well as transactions
  @guest = Guest.includes(photo_attachment: :blob, transactions: :guest).find(params[:id])
    authorize @guest
    @guests = policy_scope(Guest)
  rescue ActiveRecord::RecordNotFound
    alert_error_message = t('.not_found')
    redirect_to guests_url, alert: alert_error_message unless @guest
  end

  def guest_params
    params.require(:guest).permit(
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
    guest_params.each_key do |field|
      next if @guest.respond_to?(field)

      add_field_to_schema(field)
    end
  end

  def add_field_to_schema(field)
    field_type = Guest.columns_hash[field.to_s]&.type || :string
    @guest.class.connection.add_column(@guest.class.table_name, field, field_type)
    @guest.class.reset_column_information
  end

  # Helper method to include the photo URL in the guest data
  def guest_with_avatar_url(guests)
    guests.map do |guest|
      guest.as_json.merge(
        avatar_url: guest.photo.attached? ? rails_blob_url(guest.photo, only_path: false) : nil
      )
    end
  end
end
