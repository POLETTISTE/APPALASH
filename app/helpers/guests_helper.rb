# frozen_string_literal: true

module GuestsHelper
  # GUEST GENERAL
  def field(form, name, options = {})
  label = t("guests.show.guest_health.health_#{name}", default: name.to_s.humanize)

  id = "guest_#{name}"
  css_class = options[:class] || 'mt-2 block w-full p-2 border border-gray-300 rounded'
  x_show = options[:x_show] || 'showForm'

  content_tag :div, x_show: x_show do
    concat content_tag(:label, label, for: id, class: "block text-sm font-medium text-gray-700 mb-1")

    if name == :notes
      concat form.text_area(name, id: id, class: css_class, rows: 4)
    else
      concat form.text_field(name, id: id, class: css_class)
    end
  end
end


  def how_do_you_know_us_options
    I18n.t('guest_options.how_do_you_know_us_options').values
  end

  # LASH OPTIONS
  def lash_desired_effect_options
    I18n.t('guest_options.lash_desired_effect_options').values
  end

  def lash_face_diagnostic_options
    I18n.t('guest_options.lash_face_diagnostic_options').values
  end

  def lash_asymmetry_diagnostic_options
    I18n.t('guest_options.lash_asymmetry_diagnostic_options').values
  end

  def lash_eyelid_morphology_diagnostic_options
    I18n.t('guest_options.lash_eyelid_morphology_diagnostic_options').values
  end

  def lash_alignment_morphology_diagnostic_options
    I18n.t('guest_options.lash_alignment_morphology_diagnostic_options').values
  end

  def lash_proportion_morphology_diagnostic_options
    I18n.t('guest_options.lash_proportion_morphology_diagnostic_options').values
  end

  def lash_density_options
    I18n.t('guest_options.lash_density_options').values
  end

  def lash_style_options
    I18n.t('guest_options.lash_style_options').values
  end

  def lash_extensions_brand_options
    I18n.t('guest_options.lash_extensions_brand_options').values
  end

  def lash_extensions_curvature_options
    I18n.t('guest_options.lash_extensions_curvature_options').values
  end

  def lash_extensions_glue_options
    I18n.t('guest_options.lash_extensions_glue_options').values
  end
end
