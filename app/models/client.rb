# frozen_string_literal: true

class Client < ApplicationRecord

  include PgSearch::Model
  
  pg_search_scope :search_by_name_and_firstname,
    against: [ :name, :firstname ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
