class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :topics, through: :labellings
end
