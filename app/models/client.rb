# frozen_string_literal: true

class Client < ApplicationRecord
  has_one_attached :photo
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :firstname, presence: true

  # search postgreSQL better way
  include PgSearch::Model
  pg_search_scope :search_by_general_informations,
                  against: %i[name firstname email phone],
                  using: {
                    tsearch: { prefix: true }
                  }
  # Returns the full name by concatenating the 'name' and 'firstname' attributes.
  def full_name
    "#{name} #{firstname}"
  end
end
