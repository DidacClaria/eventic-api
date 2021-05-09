class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true
  validates :login_token, allow_nil: true, uniqueness: true

  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :role, presence: true, on: :create

  mount_uploader :image, PictureUploader
  has_many :entrada_usuarios
  has_many :favourites
  has_many :ratings
end
