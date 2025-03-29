# frozen_string_literal: true

module TransactionCalculations
  extend ActiveSupport::Concern

  included do
    before_save :calculate_total_price
  end

  private

  def calculate_total_price
    self.total_price = services.sum { |p| p['price'].to_f }
  end
end
