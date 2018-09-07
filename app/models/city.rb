class City < ApplicationRecord
  # model association
  belongs_to :country

  # validation
  validates_presence_of :name
end
