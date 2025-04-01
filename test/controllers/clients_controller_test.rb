# frozen_string_literal: true

require 'test_helper'

class GuestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @guest = guests(:one)
  end

  test 'should get index' do
    get guests_url
    assert_response :success
  end

  test 'should get new' do
    get new_guest_url
    assert_response :success
  end

  test 'should create guest' do
    assert_difference('Guest.count') do
      post guests_url,
           params: { guest: { address: @guest.address, birthdate: @guest.birthdate, city: @guest.city,
                              country: @guest.country, email: @guest.email, firstname: @guest.firstname, health_allergy: @guest.health_allergy, health_chemotherapy: @guest.health_chemotherapy, health_contact_lenses: @guest.health_contact_lenses, health_diabetes: @guest.health_diabetes, health_dry_eyes: @guest.health_dry_eyes, health_eyes_allergy: @guest.health_eyes_allergy, health_first_application: @guest.health_first_application, health_itch: @guest.health_itch, health_lie_down: @guest.health_lie_down, health_notes: @guest.health_notes, health_pregnancy: @guest.health_pregnancy, health_surgery: @guest.health_surgery, health_teary_eyes: @guest.health_teary_eyes, how_do_you_know_us: @guest.how_do_you_know_us, lash_alignment_morphology_diagnostic: @guest.lash_alignment_morphology_diagnostic, lash_asymmetry_diagnostic: @guest.lash_asymmetry_diagnostic, lash_curvature_diagnostic: @guest.lash_curvature_diagnostic, lash_density: @guest.lash_density, lash_desired_effect: @guest.lash_desired_effect, lash_event: @guest.lash_event, lash_extensions_brand: @guest.lash_extensions_brand, lash_extensions_curvature: @guest.lash_extensions_curvature, lash_extensions_glue: @guest.lash_extensions_glue, lash_extensions_pretreatment_booster: @guest.lash_extensions_pretreatment_booster, lash_extensions_pretreatment_superbonder: @guest.lash_extensions_pretreatment_superbonder, lash_extensions_thickness: @guest.lash_extensions_thickness, lash_eyelid_morphology_diagnostic: @guest.lash_eyelid_morphology_diagnostic, lash_face_diagnostic: @guest.lash_face_diagnostic, lash_length_diagnostic: @guest.lash_length_diagnostic, lash_mapping: @guest.lash_mapping, lash_notes: @guest.lash_notes, lash_proportion_morphology_diagnostic: @guest.lash_proportion_morphology_diagnostic, lash_style: @guest.lash_style, lash_texture: @guest.lash_texture, lash_thickness_diagnostic: @guest.lash_thickness_diagnostic, name: @guest.name, notes: @guest.notes, phone: @guest.phone, zip_code: @guest.zip_code } }
    end

    assert_redirected_to guest_url(Guest.last)
  end

  test 'should show guest' do
    get guest_url(@guest)
    assert_response :success
  end

  test 'should get edit' do
    get edit_guest_url(@guest)
    assert_response :success
  end

  test 'should update guest' do
    patch guest_url(@guest),
          params: { guest: { address: @guest.address, birthdate: @guest.birthdate, city: @guest.city,
                             country: @guest.country, email: @guest.email, firstname: @guest.firstname, health_allergy: @guest.health_allergy, health_chemotherapy: @guest.health_chemotherapy, health_contact_lenses: @guest.health_contact_lenses, health_diabetes: @guest.health_diabetes, health_dry_eyes: @guest.health_dry_eyes, health_eyes_allergy: @guest.health_eyes_allergy, health_first_application: @guest.health_first_application, health_itch: @guest.health_itch, health_lie_down: @guest.health_lie_down, health_notes: @guest.health_notes, health_pregnancy: @guest.health_pregnancy, health_surgery: @guest.health_surgery, health_teary_eyes: @guest.health_teary_eyes, how_do_you_know_us: @guest.how_do_you_know_us, lash_alignment_morphology_diagnostic: @guest.lash_alignment_morphology_diagnostic, lash_asymmetry_diagnostic: @guest.lash_asymmetry_diagnostic, lash_curvature_diagnostic: @guest.lash_curvature_diagnostic, lash_density: @guest.lash_density, lash_desired_effect: @guest.lash_desired_effect, lash_event: @guest.lash_event, lash_extensions_brand: @guest.lash_extensions_brand, lash_extensions_curvature: @guest.lash_extensions_curvature, lash_extensions_glue: @guest.lash_extensions_glue, lash_extensions_pretreatment_booster: @guest.lash_extensions_pretreatment_booster, lash_extensions_pretreatment_superbonder: @guest.lash_extensions_pretreatment_superbonder, lash_extensions_thickness: @guest.lash_extensions_thickness, lash_eyelid_morphology_diagnostic: @guest.lash_eyelid_morphology_diagnostic, lash_face_diagnostic: @guest.lash_face_diagnostic, lash_length_diagnostic: @guest.lash_length_diagnostic, lash_mapping: @guest.lash_mapping, lash_notes: @guest.lash_notes, lash_proportion_morphology_diagnostic: @guest.lash_proportion_morphology_diagnostic, lash_style: @guest.lash_style, lash_texture: @guest.lash_texture, lash_thickness_diagnostic: @guest.lash_thickness_diagnostic, name: @guest.name, notes: @guest.notes, phone: @guest.phone, zip_code: @guest.zip_code } }
    assert_redirected_to guest_url(@guest)
  end

  test 'should destroy guest' do
    assert_difference('guest.count', -1) do
      delete guest_url(@guest)
    end

    assert_redirected_to guests_url
  end
end
