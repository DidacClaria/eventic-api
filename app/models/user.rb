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
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
      generate_token(:password_reset_token)
      self.password_reset_send_at = Time.zone.now
      save!
      print "send_password_reset-------------------------------------------------"
      UserEmailMailer.password_reset(self).deliver
     
  end


end
