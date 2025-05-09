module NavbarHelper
  def active_class(link_path)
    base_classes = 'navbar-base navbar-text-large'  # Use your custom classes here

    is_home = link_path == '/guests' && (request.path == '/' || request.path == "/#{I18n.locale}")
    localized_link_path = I18n.locale == I18n.default_locale ? link_path : "/#{I18n.locale}#{link_path}"
    is_active = is_home || request.path.start_with?(localized_link_path)

    if is_active
      return "#{base_classes} navbar-custom-active"
    end

    "#{base_classes} navbar-custom-inactive"
  end
end
