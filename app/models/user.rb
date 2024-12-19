# frozen_string_literal: true

class User < ApplicationRecord
  # Associations
  has_one_attached :avatar

  has_many :services, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :transactions, dependent: :destroy

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # Validations
  validates :website, presence: true, uniqueness: true,
                      format: { without: /\s/, message: 'cannot contain spaces' }

  validate :validate_website_format
  validate :ensure_single_admin, if: :admin_changed?

  private

  def validate_website_format
    return if website.blank?

    return unless website.downcase == 'appalash'

    errors.add(:website, 'cannot be "appalash". This is a reserved name.')
  end

  def ensure_single_admin
    return unless admin? && User.where(admin: true).where.not(id: id).exists?

    errors.add(:admin, 'There can only be one admin user.')
  end
end
