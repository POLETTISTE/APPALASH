# frozen_string_literal: true

class Transaction < ApplicationRecord
  include TransactionDateFormatting
  include TransactionValidations
  include TransactionCalculations

  belongs_to :guest
  belongs_to :user

  include PgSearch::Model
  pg_search_scope :search_by_general_informations,
                  against: %i[name firstname email phone],
                  associated_against: {
                    user: :email
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
