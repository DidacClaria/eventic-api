class Tag < ApplicationRecord
    validates :tag_name, uniqueness: true
end
