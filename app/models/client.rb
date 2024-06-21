# frozen_string_literal: true

class Client < ApplicationRecord
  has_one_attached :photo
  has_many :transactions, dependent: :destroy

  def full_name
    "#{name} #{firstname}"
  end
end
