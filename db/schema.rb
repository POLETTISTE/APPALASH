# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_712_130_039) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.bigint 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.bigint 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'clients', force: :cascade do |t|
    t.string 'name'
    t.string 'firstname'
    t.string 'email'
    t.string 'phone'
    t.string 'address'
    t.string 'zip_code'
    t.string 'city'
    t.string 'country'
    t.date 'birthdate'
    t.text 'how_do_you_know_us'
    t.text 'notes'
    t.text 'lash_desired_effect'
    t.text 'lash_face_diagnostic'
    t.text 'lash_asymmetry_diagnostic'
    t.text 'lash_eyelid_morphology_diagnostic'
    t.text 'lash_alignment_morphology_diagnostic'
    t.float 'lash_proportion_morphology_diagnostic'
    t.float 'lash_thickness_diagnostic'
    t.integer 'lash_length_diagnostic'
    t.boolean 'lash_curvature_diagnostic'
    t.text 'lash_style'
    t.text 'lash_notes'
    t.text 'lash_mapping'
    t.text 'lash_event'
    t.boolean 'lash_texture'
    t.text 'lash_density'
    t.text 'lash_extensions_brand'
    t.text 'lash_extensions_curvature'
    t.integer 'lash_extensions_thickness'
    t.text 'lash_extensions_glue'
    t.boolean 'lash_extensions_pretreatment_superbonder'
    t.boolean 'lash_extensions_pretreatment_booster'
    t.boolean 'health_diabetes'
    t.boolean 'health_pregnancy'
    t.boolean 'health_dry_eyes'
    t.boolean 'health_teary_eyes'
    t.boolean 'health_allergy'
    t.boolean 'health_contact_lenses'
    t.boolean 'health_surgery'
    t.boolean 'health_chemotherapy'
    t.boolean 'health_eyes_allergy'
    t.boolean 'health_itch'
    t.boolean 'health_first_application'
    t.boolean 'health_lie_down'
    t.text 'health_notes'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_clients_on_user_id'
  end

  create_table 'services', force: :cascade do |t|
    t.string 'name'
    t.float 'price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_services_on_user_id'
  end

  create_table 'transactions', force: :cascade do |t|
    t.date 'date'
    t.bigint 'client_id', null: false
    t.json 'services', default: []
    t.float 'total_price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['client_id'], name: 'index_transactions_on_client_id'
    t.index ['user_id'], name: 'index_transactions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.boolean 'admin'
    t.string 'website'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['website'], name: 'index_users_on_website', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'clients', 'users'
  add_foreign_key 'services', 'users'
  add_foreign_key 'transactions', 'clients'
  add_foreign_key 'transactions', 'users'
end
