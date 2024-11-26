# frozen_string_literal: true

require 'application_system_test_case'

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test 'visiting the index' do
    visit clients_url
    assert_selector 'h1', text: 'Clients'
  end

  test 'should create client' do
    visit clients_url
    click_on 'New client'

    fill_in 'Address', with: @client.address
    fill_in 'Birthdate', with: @client.birthdate
    fill_in 'City', with: @client.city
    fill_in 'Country', with: @client.country
    fill_in 'Email', with: @client.email
    fill_in 'Firstname', with: @client.firstname
    check 'Health allergy' if @client.health_allergy
    check 'Health chemotherapy' if @client.health_chemotherapy
    check 'Health contact lenses' if @client.health_contact_lenses
    check 'Health diabetes' if @client.health_diabetes
    check 'Health dry eyes' if @client.health_dry_eyes
    check 'Health eyes allergy' if @client.health_eyes_allergy
    check 'Health first application' if @client.health_first_application
    check 'Health itch' if @client.health_itch
    check 'Health lie down' if @client.health_lie_down
    fill_in 'Health notes', with: @client.health_notes
    check 'Health pregnancy' if @client.health_pregnancy
    check 'Health surgery' if @client.health_surgery
    check 'Health teary eyes' if @client.health_teary_eyes
    fill_in 'How do you know us', with: @client.how_do_you_know_us
    fill_in 'Lash alignment morphology diagnostic', with: @client.lash_alignment_morphology_diagnostic
    fill_in 'Lash asymmetry diagnostic', with: @client.lash_asymmetry_diagnostic
    check 'Lash curvature diagnostic' if @client.lash_curvature_diagnostic
    fill_in 'Lash density', with: @client.lash_density
    fill_in 'Lash desired effect', with: @client.lash_desired_effect
    fill_in 'Lash event', with: @client.lash_event
    fill_in 'Lash extensions brand', with: @client.lash_extensions_brand
    fill_in 'Lash extensions curvature', with: @client.lash_extensions_curvature
    fill_in 'Lash extensions glue', with: @client.lash_extensions_glue
    check 'Lash extensions pretreatment booster' if @client.lash_extensions_pretreatment_booster
    check 'Lash extensions pretreatment superbonder' if @client.lash_extensions_pretreatment_superbonder
    fill_in 'Lash extensions thickness', with: @client.lash_extensions_thickness
    fill_in 'Lash eyelid morphology diagnostic', with: @client.lash_eyelid_morphology_diagnostic
    fill_in 'Lash face diagnostic', with: @client.lash_face_diagnostic
    fill_in 'Lash length diagnostic', with: @client.lash_length_diagnostic
    fill_in 'Lash mapping', with: @client.lash_mapping
    fill_in 'Lash notes', with: @client.lash_notes
    fill_in 'Lash proportion morphology diagnostic', with: @client.lash_proportion_morphology_diagnostic
    fill_in 'Lash style', with: @client.lash_style
    check 'Lash texture' if @client.lash_texture
    fill_in 'Lash thickness diagnostic', with: @client.lash_thickness_diagnostic
    fill_in 'Name', with: @client.name
    fill_in 'Notes', with: @client.notes
    fill_in 'Phone', with: @client.phone
    fill_in 'Zip code', with: @client.zip_code
    click_on 'Create Client'

    assert_text 'Client was successfully created'
    click_on 'Back'
  end

  test 'should update Client' do
    visit client_url(@client)
    click_on 'Edit this client', match: :first

    fill_in 'Address', with: @client.address
    fill_in 'Birthdate', with: @client.birthdate
    fill_in 'City', with: @client.city
    fill_in 'Country', with: @client.country
    fill_in 'Email', with: @client.email
    fill_in 'Firstname', with: @client.firstname
    check 'Health allergy' if @client.health_allergy
    check 'Health chemotherapy' if @client.health_chemotherapy
    check 'Health contact lenses' if @client.health_contact_lenses
    check 'Health diabetes' if @client.health_diabetes
    check 'Health dry eyes' if @client.health_dry_eyes
    check 'Health eyes allergy' if @client.health_eyes_allergy
    check 'Health first application' if @client.health_first_application
    check 'Health itch' if @client.health_itch
    check 'Health lie down' if @client.health_lie_down
    fill_in 'Health notes', with: @client.health_notes
    check 'Health pregnancy' if @client.health_pregnancy
    check 'Health surgery' if @client.health_surgery
    check 'Health teary eyes' if @client.health_teary_eyes
    fill_in 'How do you know us', with: @client.how_do_you_know_us
    fill_in 'Lash alignment morphology diagnostic', with: @client.lash_alignment_morphology_diagnostic
    fill_in 'Lash asymmetry diagnostic', with: @client.lash_asymmetry_diagnostic
    check 'Lash curvature diagnostic' if @client.lash_curvature_diagnostic
    fill_in 'Lash density', with: @client.lash_density
    fill_in 'Lash desired effect', with: @client.lash_desired_effect
    fill_in 'Lash event', with: @client.lash_event
    fill_in 'Lash extensions brand', with: @client.lash_extensions_brand
    fill_in 'Lash extensions curvature', with: @client.lash_extensions_curvature
    fill_in 'Lash extensions glue', with: @client.lash_extensions_glue
    check 'Lash extensions pretreatment booster' if @client.lash_extensions_pretreatment_booster
    check 'Lash extensions pretreatment superbonder' if @client.lash_extensions_pretreatment_superbonder
    fill_in 'Lash extensions thickness', with: @client.lash_extensions_thickness
    fill_in 'Lash eyelid morphology diagnostic', with: @client.lash_eyelid_morphology_diagnostic
    fill_in 'Lash face diagnostic', with: @client.lash_face_diagnostic
    fill_in 'Lash length diagnostic', with: @client.lash_length_diagnostic
    fill_in 'Lash mapping', with: @client.lash_mapping
    fill_in 'Lash notes', with: @client.lash_notes
    fill_in 'Lash proportion morphology diagnostic', with: @client.lash_proportion_morphology_diagnostic
    fill_in 'Lash style', with: @client.lash_style
    check 'Lash texture' if @client.lash_texture
    fill_in 'Lash thickness diagnostic', with: @client.lash_thickness_diagnostic
    fill_in 'Name', with: @client.name
    fill_in 'Notes', with: @client.notes
    fill_in 'Phone', with: @client.phone
    fill_in 'Zip code', with: @client.zip_code
    click_on 'Update Client'

    assert_text 'Client was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Client' do
    visit client_url(@client)
    click_on 'Destroy this client', match: :first

    assert_text 'Client was successfully destroyed'
  end
end
