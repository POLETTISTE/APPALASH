class Transaction < ApplicationRecord
  belongs_to :client

  # serialize :prestations, Array

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price = prestations.sum { |p| p['price'].to_f }
  end

end
