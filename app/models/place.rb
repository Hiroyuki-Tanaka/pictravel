class Place < ActiveRecord::Base
geocoded_by :name
after_validation :geocode, if: :name_changed?


belongs_to :picture

end
