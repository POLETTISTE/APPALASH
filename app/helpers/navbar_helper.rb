module NavbarHelper
  def active_class(link_path)
    base_classes = 'font-semibold transition duration-200 relative group text-base md:text-lg lg:text-xl'

    is_home = link_path == '/guests' && (request.path == '/' || request.path == "/#{I18n.locale}")
    localized_link_path = I18n.locale == I18n.default_locale ? link_path : "/#{I18n.locale}#{link_path}"
    is_active = is_home || request.path.start_with?(localized_link_path)

    if is_active
      return "#{base_classes} text-customPink bg-customPink bg-opacity-20 border-l-8 border-customPink active-link"
    end

    "#{base_classes} text-black hover:text-customPink border-l-8 border-white"
  end
end
