# frozen_string_literal: true

# app/helpers/application_helper.rb
module ApplicationHelper
  def full_user_name
    client = Client.find_by(id: 12) # Assuming client with ID 12
    client.firstname + ' ' + client.name
  end
end
