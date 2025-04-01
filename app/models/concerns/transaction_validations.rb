# frozen_string_literal: true

module TransactionValidations
  extend ActiveSupport::Concern

  included do
    validates :guest_id, presence: true
    validates :date, presence: true
    validate :at_least_one_service_selected
  end

  private

  def at_least_one_service_selected
    return unless services.blank? || services.all? { |service| service['name'].blank? || service['price'].blank? }

    errors.add(:services, 'must include at least one valid service')
  end
end
