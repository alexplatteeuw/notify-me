class SeasonsAndEpisodesCreatorJob < ApplicationJob
  queue_as :default

  def perform(favoritable_type, favoritable_id)
    if favoritable_type == 'TvShow'
      tv_show = TvShow.find(favoritable_id)
      
      seasons_attributes = Tmdb::Service.seasons_by_tv_show(tv_show.tmdb_id)
      seasons_ids = tv_show.seasons.upsert_all(seasons_attributes, unique_by: :tmdb_id)
      @seasons = Season.find(seasons_ids.rows)

      episodes_attributes = Tmdb::Service.episodes(tmdb_id: tv_show.tmdb_id, number_of_seasons: tv_show.number_of_seasons)
      @seasons.each do |season|
        attributes = episodes_attributes.select { |episode_attributes| episode_attributes[:season_number] == season.season_number }
        season.episodes.upsert_all(attributes)
      end
    end
  end
end
