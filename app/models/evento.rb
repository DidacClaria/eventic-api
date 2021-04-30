class Evento < ApplicationRecord

	has_many :entrada_usuarios
  has_many :event_tags
  has_many :tag, :through => :event_tags
	has_many :event_images
	has_many :favourites
	attr_accessor :event_image_data
end
