# frozen_string_literal: true

class Guest < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :transactions, dependent: :destroy
  has_one :lash, dependent: :destroy
  has_one :extension, dependent: :destroy
  has_one :health, dependent: :destroy

  accepts_nested_attributes_for :lash
  accepts_nested_attributes_for :extension
  accepts_nested_attributes_for :health

  validates :name, presence: true
  validates :firstname, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true

  before_create :build_associated_records

  def as_json(options = {})
    super(options.merge(except: %i[lash_attributes extension_attributes health_attributes],
                        include: { lash: { only: Lash.attribute_names - %w[id guest_id created_at updated_at] },
                                   extension: { only: Extension.attribute_names - %w[id guest_id created_at
                                                                                     updated_at] },
                                   health: { only: Health.attribute_names - %w[id guest_id created_at updated_at] } }))
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
    return name if firstname.blank?

    "#{firstname.capitalize} #{name.upcase} "
  end

  private

  def build_associated_records
    build_lash unless lash
    build_extension unless extension
    build_health unless health
  end
end
