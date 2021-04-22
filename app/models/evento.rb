class Evento < ApplicationRecord
	has_many :entrada_usuarios
	has_many :event_images
	attr_accessor :event_image_data

end
