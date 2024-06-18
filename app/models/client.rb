# frozen_string_literal: true

class Client < ApplicationRecord
  # uuid
  self.primary_key = 'id'

  has_one_attached :photo
  attr_accessor :remove_photo

  include PgSearch::Model

  pg_search_scope :search_by_personnal_information,
                  against: %i[name firstname phone email],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
end
