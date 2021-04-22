class EventTag < ApplicationRecord
    belongs_to :evento, optional: true
    belongs_to :tag
end
