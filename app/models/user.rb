class User < ApplicationRecord
  has_secure_password
  has_secure_token :login_token
  
  validates :email, uniqueness: true
  validates :login_token, uniqueness: true

  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, on: :create

  validates :role, presence: true, on: :create

end
