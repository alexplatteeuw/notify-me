class Episode < ApplicationRecord
  belongs_to :season
  
  scope :upcoming, -> { where("episodes.air_date > ?", Time.now).order(air_date: :asc) }
  scope :aired, -> { where("episodes.air_date < ?", Time.now).order(air_date: :asc) } 

  validates :tmdb_id, presence: true, uniqueness: true

  def self.bulk_create(season:, attributes:)
    attributes = attributes.select { |attribute| attribute[:season_number] == season.season_number }
    episodes_ids = season.episodes.upsert_all(attributes, unique_by: :tmdb_id)
    episodes = Episode.find(episodes_ids.rows)
    episodes
  end
  
  def start_time
    air_date
  end
  
  def tv_show_name
    season.tv_show_name
  end
end
