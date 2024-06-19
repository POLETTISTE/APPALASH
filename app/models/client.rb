# frozen_string_literal: true

class Client < ApplicationRecord
  has_one_attached :photo
  # uuid
  self.primary_key = 'id'
  


  include PgSearch::Model

  pg_search_scope :search_by_personnal_information,
                  against: %i[name firstname phone email],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }

  # Validations
  validates :name, presence: true
  validates :firstname, presence: true
end
