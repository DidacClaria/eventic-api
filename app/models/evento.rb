class Evento < ApplicationRecord
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :event_tags
  has_many :tag, :through => :event_tags
  
end
