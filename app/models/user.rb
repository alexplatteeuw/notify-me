class User < ApplicationRecord
  acts_as_favoritor
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  def tv_shows
    favorited_by_type('TvShow')
  end
end
