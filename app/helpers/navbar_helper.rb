module NavbarHelper
  def active_class(link_path)
    # Adjust the link_path to consider the locale
    localized_link_path = "#{I18n.locale == I18n.default_locale ? '' : "/#{I18n.locale}"}#{link_path}"

    if current_page?(localized_link_path)
      # Highlight the link if it's the current page
      'text-customPink font-semibold transition duration-200'
    else
      # Default class if not active
      'text-white hover:text-indigo-400 font-semibold transition duration-200'
    end
  end
end
