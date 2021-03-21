# frozen_string_literal: true

class Company < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  self.primary_key = "email"
  include DeviseTokenAuth::Concerns::User
end
