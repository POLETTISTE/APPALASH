# frozen_string_literal: true

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

  def validate_website_format
    return if website.blank? || website.match(/\A\S+\z/)

    errors.add(:website,
               'is not valid. Please ensure no spaces are included.')
  end
end
