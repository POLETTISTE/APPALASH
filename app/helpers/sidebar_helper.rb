module SidebarHelper
  def active_class(link_path)
    # Check if the current request path is the root path ("/") or the locale-prefixed root ("/en")
    if link_path == "/clients" && (request.path == "/" || request.path == "/#{I18n.locale}")
      # If we are on the root path ("/" or "/en"), apply the active class to "/clients"
      return 'text-customPink bg-customPink bg-opacity-20 font-semibold border-l-8 border-customPink transition duration-200'
    end

    # Handle the localized link path, making sure we don't add the locale for the default locale
    localized_link_path = I18n.locale == I18n.default_locale ? link_path : "/#{I18n.locale}#{link_path}"

    # For other links, check if the current path starts with the localized path (accounting for dynamic segments)
    if request.path.start_with?(localized_link_path)
      return 'text-customPink bg-customPink bg-opacity-20 font-semibold border-l-8 border-customPink transition duration-200'
    end

    # Default class if not active
    'text-black hover:text-customPink font-semibold border-l-8 border-transparent transition duration-200'
  end
end
