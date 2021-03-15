class TvShow < ApplicationRecord
  acts_as_favoritable

  has_many :seasons, dependent: :destroy
  has_many :people, dependent: :destroy
  has_many :episodes, through: :seasons

  validates :tmdb_id, presence: true, uniqueness: true

  def returning?
    status == "Returning"
  end

  def upcoming_episodes
    episodes.upcoming
  end

  def aired_episodes
    episodes.aired
  end

  def upcoming_episode
    upcoming_episodes.last
  end

  def last_aired_episode
    aired_episodes.last
  end
end
