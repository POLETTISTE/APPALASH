# frozen_string_literal: true

module UserValidations
  extend ActiveSupport::Concern

  # List of forbidden words
  FORBIDDEN_WEBSITES = %w[appalash example testwebsite].freeze

  included do
    validate :validate_forbidden_websites
    validate :ensure_single_admin, if: :admin_changed?
  end

  private

  def validate_forbidden_websites
    return if website.blank?

    return unless FORBIDDEN_WEBSITES.include?(website.downcase)

    errors.add(:website, 'is forbidden. Please choose another one.')
  end

  def ensure_single_admin
    return unless admin? && User.where(admin: true).where.not(id: id).exists?

    errors.add(:admin, 'There can only be one admin user.')
  end
end
