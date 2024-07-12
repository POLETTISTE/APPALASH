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

  validates :website, presence: true, uniqueness: true

end
