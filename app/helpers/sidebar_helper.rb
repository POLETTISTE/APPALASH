module SidebarHelper
  def active_class(link_path)
    # Account for the localized path (including locale) or root path
    localized_link_path = "/#{I18n.locale}#{link_path}"

    # Special case for the root path ("/") to check if we're on the homepage
    if link_path == "/clients" && (request.path == "/" || request.path == "/#{I18n.locale}")
      # If we're on the root path ("/" or "/en"), apply the active class to "/clients"
      return 'text-customPink bg-customPink bg-opacity-20 font-semibold border-l-8 border-customPink transition duration-200'
    end

    # For other links, check if the current path starts with the localized path (accounting for dynamic segments)
    if request.path.start_with?(localized_link_path)
      return 'text-customPink bg-customPink bg-opacity-20 font-semibold border-l-8 border-customPink transition duration-200'
    end

    # Default class if not active
    'text-black hover:text-customPink font-semibold transition duration-200'
  end
end
