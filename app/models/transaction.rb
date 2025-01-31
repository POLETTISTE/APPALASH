# frozen_string_literal: true

class Transaction < ApplicationRecord
  include HasFormattedDate

  belongs_to :guest
  belongs_to :user
  validates :guest_id, presence: true
  validates :date, presence: true
  validate :at_least_one_service_selected

    # Custom validation method for services
    def at_least_one_service_selected
      if services.blank? || services.all? { |service| service['name'].blank? || service['price'].blank? }
        errors.add(:services, "must include at least one valid service")
      end
    end

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
