class Usuari < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, on: :create

  validates :tipus, presence: true, on: :create
  
end
