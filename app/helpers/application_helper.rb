# frozen_string_literal: true

# app/helpers/application_helper.rb
module ApplicationHelper
  def client_name
    client = Client.find_by(id: 12) # Assuming client with ID 12
    client&.name
  end
end
