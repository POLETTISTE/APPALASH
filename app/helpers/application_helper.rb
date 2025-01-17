# frozen_string_literal: true

# app/helpers/application_helper.rb
module ApplicationHelper
  def full_user_name
    guest = Guest.find_by(id: 12) # Assuming guest with ID 12
    "#{guest.firstname} #{guest.name}"
  end
end
