class Plant < ApplicationRecord
    belongs_to :user
    geocoded_by :zipcode
    after_validation :geocode
    validates :name, presence: true

end
