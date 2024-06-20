# frozen_string_literal: true

class Prestation < ApplicationRecord
  self.primary_key = 'id'

  def name_with_price
    "#{name} - #{price}"
  end
end
