# frozen_string_literal: true

module NavbarHelper
  def active_class(link_path)
    if current_page?(root_path) && link_path == '/dashboard'
      # If we're at the root and the link is "/dashboard", highlight it as active
      'text-customPink font-semibold transition duration-200'
    else
      # For other cases, check if the link matches the current path
      current_page?(link_path) ? 'text-customPink font-semibold transition duration-200' : 'text-black hover:text-indigo-400 font-semibold transition duration-200'
    end
  end
end
