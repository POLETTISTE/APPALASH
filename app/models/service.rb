# frozen_string_literal: true

class Service < ApplicationRecord
  belongs_to :user

  self.primary_key = 'id'

  def name_with_price
    "#{name} - #{price}"
  end
end
