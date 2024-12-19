# frozen_string_literal: true

module ForbiddenWebsite
  extend ActiveSupport::Concern

  # List of forbidden words
  FORBIDDEN_WEBSITES = %w[appalash example testwebsite].freeze

  included do
    # Model validation if included in any model
    validate :validate_forbidden_websites
  end

  private

  # Validation method for forbidden words
  def validate_forbidden_websites
    return if website.blank?

    return unless FORBIDDEN_WEBSITES.include?(website.downcase)

    errors.add(:website, 'is forbidden. Please choose another one.')
  end
end
