class Year < ApplicationRecord
  has_many :yearings, dependent: :destroy
  has_many :topics, through: :yearings
end