class Country < ApplicationRecord
  # model association
  has_many :cities, dependent: :destroy

  # validations
  validates_presence_of :name, :created_by
end
