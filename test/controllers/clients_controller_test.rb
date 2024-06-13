# frozen_string_literal: true

require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = clients(:one)
  end

  test 'should get index' do
    get clients_url
    assert_response :success
  end

  test 'should get new' do
    get new_client_url
    assert_response :success
  end

  test 'should create client' do
    assert_difference('Client.count') do
      post clients_url,
           params: { client: { address: @client.address, birthdate: @client.birthdate, city: @client.city,
                               country: @client.country, email: @client.email, firstname: @client.firstname, health_allergy: @client.health_allergy, health_chemotherapy: @client.health_chemotherapy, health_contact_lenses: @client.health_contact_lenses, health_diabetes: @client.health_diabetes, health_dry_eyes: @client.health_dry_eyes, health_eyes_allergy: @client.health_eyes_allergy, health_first_application: @client.health_first_application, health_itch: @client.health_itch, health_lie_down: @client.health_lie_down, health_notes: @client.health_notes, health_pregnancy: @client.health_pregnancy, health_surgery: @client.health_surgery, health_teary_eyes: @client.health_teary_eyes, how_do_you_know_us: @client.how_do_you_know_us, lash_alignment_morphology_diagnostic: @client.lash_alignment_morphology_diagnostic, lash_asymmetry_diagnostic: @client.lash_asymmetry_diagnostic, lash_curvature_diagnostic: @client.lash_curvature_diagnostic, lash_density: @client.lash_density, lash_desired_effect: @client.lash_desired_effect, lash_event: @client.lash_event, lash_extensions_brand: @client.lash_extensions_brand, lash_extensions_curvature: @client.lash_extensions_curvature, lash_extensions_glue: @client.lash_extensions_glue, lash_extensions_pretreatment_booster: @client.lash_extensions_pretreatment_booster, lash_extensions_pretreatment_superbonder: @client.lash_extensions_pretreatment_superbonder, lash_extensions_thickness: @client.lash_extensions_thickness, lash_eyelid_morphology_diagnostic: @client.lash_eyelid_morphology_diagnostic, lash_face_diagnostic: @client.lash_face_diagnostic, lash_length_diagnostic: @client.lash_length_diagnostic, lash_mapping: @client.lash_mapping, lash_notes: @client.lash_notes, lash_proportion_morphology_diagnostic: @client.lash_proportion_morphology_diagnostic, lash_style: @client.lash_style, lash_texture: @client.lash_texture, lash_thickness_diagnostic: @client.lash_thickness_diagnostic, name: @client.name, notes: @client.notes, phone: @client.phone, zip_code: @client.zip_code } }
    end

    assert_redirected_to client_url(Client.last)
  end

  test 'should show client' do
    get client_url(@client)
    assert_response :success
  end

  test 'should get edit' do
    get edit_client_url(@client)
    assert_response :success
  end

  test 'should update client' do
    patch client_url(@client),
          params: { client: { address: @client.address, birthdate: @client.birthdate, city: @client.city,
                              country: @client.country, email: @client.email, firstname: @client.firstname, health_allergy: @client.health_allergy, health_chemotherapy: @client.health_chemotherapy, health_contact_lenses: @client.health_contact_lenses, health_diabetes: @client.health_diabetes, health_dry_eyes: @client.health_dry_eyes, health_eyes_allergy: @client.health_eyes_allergy, health_first_application: @client.health_first_application, health_itch: @client.health_itch, health_lie_down: @client.health_lie_down, health_notes: @client.health_notes, health_pregnancy: @client.health_pregnancy, health_surgery: @client.health_surgery, health_teary_eyes: @client.health_teary_eyes, how_do_you_know_us: @client.how_do_you_know_us, lash_alignment_morphology_diagnostic: @client.lash_alignment_morphology_diagnostic, lash_asymmetry_diagnostic: @client.lash_asymmetry_diagnostic, lash_curvature_diagnostic: @client.lash_curvature_diagnostic, lash_density: @client.lash_density, lash_desired_effect: @client.lash_desired_effect, lash_event: @client.lash_event, lash_extensions_brand: @client.lash_extensions_brand, lash_extensions_curvature: @client.lash_extensions_curvature, lash_extensions_glue: @client.lash_extensions_glue, lash_extensions_pretreatment_booster: @client.lash_extensions_pretreatment_booster, lash_extensions_pretreatment_superbonder: @client.lash_extensions_pretreatment_superbonder, lash_extensions_thickness: @client.lash_extensions_thickness, lash_eyelid_morphology_diagnostic: @client.lash_eyelid_morphology_diagnostic, lash_face_diagnostic: @client.lash_face_diagnostic, lash_length_diagnostic: @client.lash_length_diagnostic, lash_mapping: @client.lash_mapping, lash_notes: @client.lash_notes, lash_proportion_morphology_diagnostic: @client.lash_proportion_morphology_diagnostic, lash_style: @client.lash_style, lash_texture: @client.lash_texture, lash_thickness_diagnostic: @client.lash_thickness_diagnostic, name: @client.name, notes: @client.notes, phone: @client.phone, zip_code: @client.zip_code } }
    assert_redirected_to client_url(@client)
  end

  test 'should destroy client' do
    assert_difference('Client.count', -1) do
      delete client_url(@client)
    end

    assert_redirected_to clients_url
  end
end
