module Seasons
  def set_attributes(season)
    season_filtered = filter_attributes(season)
    transform_attributes(season_filtered)
  end

  def filter_attributes(season)
    valid_keys = %i[id air_date season_number name overview still_path vote_average episode_count]
    season.slice!(*valid_keys)
    season
  end

  def transform_attributes(season)
    season[:tmdb_id] = season.delete(:id)
    season[:created_at] = season[:updated_at] = Time.now
    season
  end
end
