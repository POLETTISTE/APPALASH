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

ActiveRecord::Schema[8.0].define(version: 20_241_218_181_510) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pg_catalog.plpgsql'
  enable_extension 'pgcrypto'

  create_table 'active_storage_attachments', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.string 'record_id', limit: 36, null: false
    t.uuid 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
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

  create_table 'active_storage_variant_records', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'clients', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
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
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_clients_on_user_id'
  end

  create_table 'extensions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.text 'brand'
    t.text 'curvature'
    t.integer 'thickness'
    t.text 'glue'
    t.uuid 'client_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'healths', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.boolean 'diabetes'
    t.boolean 'pregnancy'
    t.boolean 'dry_eyes'
    t.boolean 'teary_eyes'
    t.boolean 'allergy'
    t.boolean 'contact_lenses'
    t.boolean 'surgery'
    t.boolean 'chemotherapy'
    t.boolean 'eyes_allergy'
    t.boolean 'itch'
    t.boolean 'first_application'
    t.boolean 'lie_down'
    t.text 'notes'
    t.uuid 'client_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'lashes', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.uuid 'client_id'
    t.string 'desired_effect'
    t.string 'face_diagnostic'
    t.string 'asymmetry_diagnostic'
    t.string 'eyelid_morphology_diagnostic'
    t.string 'alignment_morphology_diagnostic'
    t.string 'proportion_morphology_diagnostic'
    t.string 'thickness_diagnostic'
    t.integer 'length_diagnostic'
    t.boolean 'curvature_diagnostic'
    t.string 'style'
    t.text 'notes'
    t.text 'mapping'
    t.text 'event'
    t.boolean 'texture'
    t.string 'density'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'services', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'name'
    t.float 'price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
    t.index ['user_id'], name: 'index_services_on_user_id'
  end

  create_table 'transactions', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.date 'date'
    t.uuid 'client_id'
    t.json 'services', default: []
    t.float 'total_price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id', null: false
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
    t.string 'website', null: false
    t.string 'name'
    t.string 'firstname'
    t.string 'language'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'clients', 'users'
  add_foreign_key 'services', 'users'
  add_foreign_key 'transactions', 'users'
end
