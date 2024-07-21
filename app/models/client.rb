# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :transactions, dependent: :destroy
  has_one :lash, dependent: :destroy
  has_one :extension, dependent: :destroy
  has_one :health, dependent: :destroy

  accepts_nested_attributes_for :lash # Make sure this line is present
  accepts_nested_attributes_for :extension # Make sure this line is present
  accepts_nested_attributes_for :health # Make sure this line is present

  validates :name, presence: true
  validates :firstname, presence: true

  before_create :build_associated_records


  def as_json(options = {})
    super(options.merge(except: %i[lash_attributes extension_attributes health_attributes],
                        include: { lash: { only: Lash.attribute_names - %w[id client_id created_at updated_at] },
                                   extension: { only: Extension.attribute_names - %w[id client_id created_at updated_at]},
                                   health: { only: Health.attribute_names - %w[id client_id created_at updated_at] }
                                  }))
  end

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

  private
  def build_associated_records
    build_lash unless lash
    build_extension unless extension
    build_health unless health
  end
end
