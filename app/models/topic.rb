class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :image, presence: true
  validates :description, presence: true
  
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  mount_uploader :docment, ImageUploader
  
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  has_many :comments
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

end
