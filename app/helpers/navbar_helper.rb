# frozen_string_literal: true

module NavbarHelper
  def active_class(link_path)
    current_page?(link_path) ? 'text-custom-pink font-semibold transition duration-200' : 'text-black hover:text-indigo-400 font-semibold transition duration-200'
  end
end

