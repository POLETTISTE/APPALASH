# frozen_string_literal: true

class User < ApplicationRecord
  include UserValidations # ✅ Use the new concern

  # Associations
  has_one_attached :avatar
  has_many :services, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :transactions, dependent: :destroy

  # Devise modules
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :confirmable, :timeoutable

  # Validations
  validates :website, presence: true, uniqueness: true,
                      format: { without: /\s/, message: 'cannot contain spaces' }
end
