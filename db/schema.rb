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

ActiveRecord::Schema[7.0].define(version: 20_240_611_092_654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

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
  end
end
