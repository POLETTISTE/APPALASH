# frozen_string_literal: true

module UserValidations
  extend ActiveSupport::Concern

  # List of forbidden words
  FORBIDDEN_WEBSITES = %w[appalash example testwebsite].freeze

  included do
    # Website validations
    validates :website, presence: true, uniqueness: true,
                        format: { without: /\s/, message: 'cannot contain spaces' }

    validate :validate_forbidden_websites
    validate :ensure_single_admin, if: :admin_changed?
  end

  private

  def validate_forbidden_websites
    return if website.blank?
    return unless FORBIDDEN_WEBSITES.include?(website.downcase)

    errors.add(:website, I18n.t('devise.registrations.edit.label_error_message'))
  end

  def ensure_single_admin
    return unless admin? && User.where(admin: true).where.not(id: id).exists?

    errors.add(:admin, I18n.t('devise.registrations.edit.label_error_message'))
  end
end
