# frozen_string_literal: true

class Client < ApplicationRecord
  has_one_attached :photo
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :firstname, presence: true

  # Returns the full name by concatenating the 'name' and 'firstname' attributes.
  def full_name
    "#{name} #{firstname}"
  end
end
