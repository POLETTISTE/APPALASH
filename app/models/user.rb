# frozen_string_literal: true

class User < ApplicationRecord
  has_many :services, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :transactions, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  # can be null but not empty
  validates :website, uniqueness: true, allow_nil: true, presence: true
end
