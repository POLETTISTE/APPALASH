# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :client
  belongs_to :user
  validates :client_id, presence: true

  # serialize :prestations, Array

  before_save :calculate_total_price
  include PgSearch::Model
  pg_search_scope :search_by_general_informations,
                  against: %i[name firstname email phone],
                  associated_against: {
                    user: :email
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
  private

  def calculate_total_price
    self.total_price = services.sum { |p| p['price'].to_f }
  end
end
