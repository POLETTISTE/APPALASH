class User < ApplicationRecord
  # Associations
  has_many :services, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :transactions, dependent: :destroy

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # Validations
  validates :website, presence: true, uniqueness: true, allow_nil: true,
                      format: {
                        without: /\s/, # Ensure no spaces
                        message: 'cannot contain spaces'
                      }

  validate :validate_website_format
  validate :only_one_admin, if: :admin_changed?

  before_save :ensure_single_admin

  def validate_website_format
    return if website.blank? || website.match(/\A\S+\z/)

    errors.add(:website, 'is not valid. Please ensure no spaces are included.')
  end

  def only_one_admin
    if admin? && User.where(admin: true).exists?
      errors.add(:admin, 'There can only be one admin user.')
    end
  end

  private

  def ensure_single_admin
    if admin? && User.where(admin: true).exists? && !admin_changed?(from: false, to: true)
      errors.add(:admin, 'There can only be one admin user.')
      throw(:abort)
    end
  end
end
