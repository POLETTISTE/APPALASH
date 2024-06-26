# # frozen_string_literal: true

# app/helpers/clients_helper.rb
module ClientsHelper
  # CLIENT GENERAL

  def how_do_you_know_us_options
    I18n.t('client_options.how_do_you_know_us_options').values
  end

  # CLIENT LASH

  def lash_desired_effect_options
    I18n.t('client_options.lash_desired_effect_options').values
  end

  def lash_face_diagnostic_options
    I18n.t('client_options.lash_face_diagnostic_options').values
  end

  def lash_asymmetry_diagnostic_options
    I18n.t('client_options.lash_asymmetry_diagnostic_options').values
  end

  def lash_eyelid_morphology_diagnostic_options
    I18n.t('client_options.lash_eyelid_morphology_diagnostic_options').values
  end

  def lash_alignment_morphology_diagnostic_options
    I18n.t('client_options.lash_alignment_morphology_diagnostic_options').values
  end

  def lash_proportion_morphology_diagnostic_options
    I18n.t('client_options.lash_proportion_morphology_diagnostic_options').values
  end

  def lash_density_options
    I18n.t('client_options.lash_density_options').values
  end

  def lash_style_options
    I18n.t('client_options.lash_style_options').values
  end

  def lash_extensions_brand_options
    I18n.t('client_options.lash_extensions_brand_options').values
  end

  def lash_extensions_curvature_options
    I18n.t('client_options.lash_extensions_curvature_options').values
  end

  def lash_extensions_glue_options
    I18n.t('client_options.lash_extensions_glue_options').values
  end
end











# # app/helpers/clients_helper.rb
# module ClientsHelper
#   #   ** CLIENT GENERAL **

#   def how_do_you_know_us_options
#     ['GOOGLE', 'PLANITY', 'RESEAUX SOCIAUX', 'PROCHE / AMI', 'AUTRE']
#   end

#   # ** CLIENT LASH **
#   # EFFET DESIRE
#   def lash_desired_effect_options
#     %w[LEGER INTERMEDIAIRE INTENSE]
#   end

#   # DIAGNOSTIC VISAGE
#   def lash_face_diagnostic_options
#     %w[ROND CARRE OVALE]
#   end

#   # DIAGNOSTIC ASYMETRIE YEUX
#   def lash_asymmetry_diagnostic_options
#     %w[AMANDES RONDS]
#   end

#   # DIAGNOSTIC PAUPIERES
#   def lash_eyelid_morphology_diagnostic_options
#     %w[GRANDES PETITES TOMBANTES]
#   end

#   # DIAGNOSTIC ALIGNEMENT
#   def lash_alignment_morphology_diagnostic_options
#     %w[DESCENDANT ALIGNE MONTANT]
#   end

#   # DIAGNOSTIC PROPORTION
#   def lash_proportion_morphology_diagnostic_options
#     %w[RAPPROCHES EGAUX ECARTES]
#   end

#   # DIAGNOSTIC DENSITE
#   def lash_density_options
#     %w[FORTE MOYENNE FAIBLE]
#   end

#   #  DIAGNOSTIC STYLE
#   def lash_style_options
#     ['NATUREL', 'SQUIRREL', 'DOLLY', 'CAT EYE']
#   end

#   #  MARQUE DES CILS
#   def lash_extensions_brand_options
#     ['LONDON LASH', 'UNE PAUSE POUDREE', 'LEXCILLENCE']
#   end

#   # COURBURE DES CILS
#   def lash_extensions_curvature_options
#     %w[C CC D L]
#   end

#   # COLLE
#   def lash_extensions_glue_options
#     ['NO CONTRAINT', 'LADY BOND', 'LEXCILLENCE']
#   end
# end
