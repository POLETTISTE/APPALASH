# frozen_string_literal: true

require 'application_system_test_case'

class GuestsTest < ApplicationSystemTestCase
  setup do
    @guest = guests(:one)
  end

  test 'visiting the index' do
    visit guests_url
    assert_selector 'h1', text: 'Guests'
  end

  test 'should create guest' do
    visit guests_url
    click_on 'New guest'

    fill_in 'Address', with: @guest.address
    fill_in 'Birthdate', with: @guest.birthdate
    fill_in 'City', with: @guest.city
    fill_in 'Country', with: @guest.country
    fill_in 'Email', with: @guest.email
    fill_in 'Firstname', with: @guest.firstname
    check 'Health allergy' if @guest.health_allergy
    check 'Health chemotherapy' if @guest.health_chemotherapy
    check 'Health contact lenses' if @guest.health_contact_lenses
    check 'Health diabetes' if @guest.health_diabetes
    check 'Health dry eyes' if @guest.health_dry_eyes
    check 'Health eyes allergy' if @guest.health_eyes_allergy
    check 'Health first application' if @guest.health_first_application
    check 'Health itch' if @guest.health_itch
    check 'Health lie down' if @guest.health_lie_down
    fill_in 'Health notes', with: @guest.health_notes
    check 'Health pregnancy' if @guest.health_pregnancy
    check 'Health surgery' if @guest.health_surgery
    check 'Health teary eyes' if @guest.health_teary_eyes
    fill_in 'How do you know us', with: @guest.how_do_you_know_us
    fill_in 'Lash alignment morphology diagnostic', with: @guest.lash_alignment_morphology_diagnostic
    fill_in 'Lash asymmetry diagnostic', with: @guest.lash_asymmetry_diagnostic
    check 'Lash curvature diagnostic' if @guest.lash_curvature_diagnostic
    fill_in 'Lash density', with: @guest.lash_density
    fill_in 'Lash desired effect', with: @guest.lash_desired_effect
    fill_in 'Lash event', with: @guest.lash_event
    fill_in 'Lash extensions brand', with: @guest.lash_extensions_brand
    fill_in 'Lash extensions curvature', with: @guest.lash_extensions_curvature
    fill_in 'Lash extensions glue', with: @guest.lash_extensions_glue
    check 'Lash extensions pretreatment booster' if @guest.lash_extensions_pretreatment_booster
    check 'Lash extensions pretreatment superbonder' if @guest.lash_extensions_pretreatment_superbonder
    fill_in 'Lash extensions thickness', with: @guest.lash_extensions_thickness
    fill_in 'Lash eyelid morphology diagnostic', with: @guest.lash_eyelid_morphology_diagnostic
    fill_in 'Lash face diagnostic', with: @guest.lash_face_diagnostic
    fill_in 'Lash length diagnostic', with: @guest.lash_length_diagnostic
    fill_in 'Lash mapping', with: @guest.lash_mapping
    fill_in 'Lash notes', with: @guest.lash_notes
    fill_in 'Lash proportion morphology diagnostic', with: @guest.lash_proportion_morphology_diagnostic
    fill_in 'Lash style', with: @guest.lash_style
    check 'Lash texture' if @guest.lash_texture
    fill_in 'Lash thickness diagnostic', with: @guest.lash_thickness_diagnostic
    fill_in 'Name', with: @guest.name
    fill_in 'Notes', with: @guest.notes
    fill_in 'Phone', with: @guest.phone
    fill_in 'Zip code', with: @guest.zip_code
    click_on 'Create Guest'

    assert_text 'Guest was successfully created'
    click_on 'Back'
  end

  test 'should update Guest' do
    visit guest_url(@guest)
    click_on 'Edit this guest', match: :first

    fill_in 'Address', with: @guest.address
    fill_in 'Birthdate', with: @guest.birthdate
    fill_in 'City', with: @guest.city
    fill_in 'Country', with: @guest.country
    fill_in 'Email', with: @guest.email
    fill_in 'Firstname', with: @guest.firstname
    check 'Health allergy' if @guest.health_allergy
    check 'Health chemotherapy' if @guest.health_chemotherapy
    check 'Health contact lenses' if @guest.health_contact_lenses
    check 'Health diabetes' if @guest.health_diabetes
    check 'Health dry eyes' if @guest.health_dry_eyes
    check 'Health eyes allergy' if @guest.health_eyes_allergy
    check 'Health first application' if @guest.health_first_application
    check 'Health itch' if @guest.health_itch
    check 'Health lie down' if @guest.health_lie_down
    fill_in 'Health notes', with: @guest.health_notes
    check 'Health pregnancy' if @guest.health_pregnancy
    check 'Health surgery' if @guest.health_surgery
    check 'Health teary eyes' if @guest.health_teary_eyes
    fill_in 'How do you know us', with: @guest.how_do_you_know_us
    fill_in 'Lash alignment morphology diagnostic', with: @guest.lash_alignment_morphology_diagnostic
    fill_in 'Lash asymmetry diagnostic', with: @guest.lash_asymmetry_diagnostic
    check 'Lash curvature diagnostic' if @guest.lash_curvature_diagnostic
    fill_in 'Lash density', with: @guest.lash_density
    fill_in 'Lash desired effect', with: @guest.lash_desired_effect
    fill_in 'Lash event', with: @guest.lash_event
    fill_in 'Lash extensions brand', with: @guest.lash_extensions_brand
    fill_in 'Lash extensions curvature', with: @guest.lash_extensions_curvature
    fill_in 'Lash extensions glue', with: @guest.lash_extensions_glue
    check 'Lash extensions pretreatment booster' if @guest.lash_extensions_pretreatment_booster
    check 'Lash extensions pretreatment superbonder' if @guest.lash_extensions_pretreatment_superbonder
    fill_in 'Lash extensions thickness', with: @guest.lash_extensions_thickness
    fill_in 'Lash eyelid morphology diagnostic', with: @guest.lash_eyelid_morphology_diagnostic
    fill_in 'Lash face diagnostic', with: @guest.lash_face_diagnostic
    fill_in 'Lash length diagnostic', with: @guest.lash_length_diagnostic
    fill_in 'Lash mapping', with: @guest.lash_mapping
    fill_in 'Lash notes', with: @guest.lash_notes
    fill_in 'Lash proportion morphology diagnostic', with: @guest.lash_proportion_morphology_diagnostic
    fill_in 'Lash style', with: @guest.lash_style
    check 'Lash texture' if @guest.lash_texture
    fill_in 'Lash thickness diagnostic', with: @guest.lash_thickness_diagnostic
    fill_in 'Name', with: @guest.name
    fill_in 'Notes', with: @guest.notes
    fill_in 'Phone', with: @guest.phone
    fill_in 'Zip code', with: @guest.zip_code
    click_on 'Update Guest'

    assert_text 'Guest was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Guest' do
    visit guest_url(@guest)
    click_on 'Destroy this guest', match: :first

    assert_text 'Guest was successfully destroyed'
  end
end
