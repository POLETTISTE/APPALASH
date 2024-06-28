# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :client
  belongs_to :user
  validates :client_id, presence: true

  # serialize :prestations, Array

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price = services.sum { |p| p['price'].to_f }
  end
end
