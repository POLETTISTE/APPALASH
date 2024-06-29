# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :transactions, dependent: :destroy

  validates :name, presence: true
  validates :firstname, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_general_informations,
                  against: %i[name firstname email phone],
                  associated_against: {
                    user: :email
                  },
                  using: {
                    tsearch: { prefix: true }
                  }

  def full_name
    "#{name} #{firstname}"
  end
end
