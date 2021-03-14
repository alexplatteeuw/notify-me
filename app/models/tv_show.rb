class TvShow < ApplicationRecord
  acts_as_favoritable

  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons

  validates :tmdb_id, presence: true, uniqueness: true

  def self.bulk_create(attributes_set)
    tv_shows_ids = TvShow.upsert_all(attributes_set, unique_by: :tmdb_id)
    tv_shows = TvShow.find(tv_shows_ids.rows)
    tv_shows
  end

  def update_with_all_attributes
    attributes = Tmdb::Service.fetch_tv_show_by(tmdb_id: self.tmdb_id)
    tv_show_id = TvShow.upsert(attributes, unique_by: :tmdb_id)
    TvShow.find(tv_show_id.rows).first
  end

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
