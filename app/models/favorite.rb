class Favorite < ApplicationRecord
  extend ActsAsFavoritor::FavoriteScopes
  after_save :create_seasons_and_episodes

  belongs_to :favoritable, polymorphic: true
  belongs_to :favoritor, polymorphic: true

  def block!
    update!(blocked: true)
  end

  def create_seasons_and_episodes
    if favoritable_type == 'TvShow'
      tv_show = favoritable_type.constantize.find(favoritable_id)
      
      seasons_attributes = FetchSeasons.run(tv_show.tmdb_id)
      seasons_ids = tv_show.seasons.upsert_all(seasons_attributes, unique_by: :tmdb_id)
      @seasons = Season.find(seasons_ids.rows)

      episodes_attributes = FetchEpisodes.run(tmdb_id: tv_show.tmdb_id, number_of_seasons: tv_show.number_of_seasons)
      @seasons.each do |season|
        attributes = episodes_attributes.select { |episode_attributes| episode_attributes[:season_number] == season.season_number }
        season.episodes.upsert_all(attributes)
      end

    end
  end
end
