module GuestsHelper
  # GUEST GENERAL
  def field(form, name, options = {})
  label = t(".#{name}") # Translates the field label
  value = form.object.send(name) # Gets the value dynamically
  id = "guest_#{name}" # Generates the input ID dynamically
  css_class = options[:class] || "mt-2 block" # Default class for styling
  toggle_variable = "showForm#{name.to_s.camelize}" # Generates the Alpine.js state variable

  content_tag :div, class: "flex items-center space-x-2" do
    concat content_tag(:strong, label)
    concat form.text_field(name, value: value, id: id, class: css_class, 
      "x-on:keydown.enter" => "#{toggle_variable} = false; $el.closest('form').submit();")

    # Validation Icon (inside the field)
    concat content_tag(:span, 
      raw(File.read(Rails.root.join('app', 'assets', 'svg', 'validate.svg'))
          .gsub('<svg', '<svg class="w-6 h-6 text-customPink"')), 
      class: "ml-2 cursor-pointer", 
      "x-on:click" => "#{toggle_variable} = false; $el.closest('form').submit();"
    )
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
