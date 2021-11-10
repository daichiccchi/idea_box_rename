class Topic < ApplicationRecord
  validates :user_id, presence: true
  validates :description, presence: true
  
  belongs_to :user
  
  mount_uploaders :images, ImageUploader
  serialize :images, JSON #SQLiteを使用する場合は、この行を追加
  mount_uploader :docment, FileUploader
  
  has_many :favorites
  # そのユーザーが保存したcデータをすべて取得することができる
  has_many :favorite_users, through: :favorites, source: 'user'
  has_many :comments
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  has_many :yearings, dependent: :destroy
  has_many :years, through: :yearings
  has_many :submits
  # そのユーザーが保存したTopicデータをすべて取得することができる
  has_many :submit_users, through: :submits, source: 'user'

end
