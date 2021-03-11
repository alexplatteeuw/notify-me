class User < ApplicationRecord
  acts_as_favoritor
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  has_one_attached :avatar
  has_many :tv_shows
  has_many :seasons, through: :tv_shows
  has_many :episodes, through: :seasons
end
