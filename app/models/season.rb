class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy

  validates :tmdb_id, presence: true, uniqueness: true

  def self.bulk_create(tv_show:, attributes:)
    seasons_ids = tv_show.seasons.upsert_all(attributes, unique_by: :tmdb_id)
    seasons = Season.find(seasons_ids.rows)
    seasons
  end
  
  def tv_show_name
    tv_show.name
  end
end
