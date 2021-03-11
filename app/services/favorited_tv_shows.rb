module FavoritedTvShows
  def set_attributes(tv_show)
    tv_show_filtered = filter_attributes(tv_show)
    transform_attributes(tv_show_filtered)
  end

  def filter_attributes(tv_show)
    valid_keys = %i[backdrop_path episode_run_time first_air_date id name number_of_seasons overview poster_path status tagline vote_average]
    tv_show.slice!(*valid_keys)
    tv_show
  end

  def transform_attributes(tv_show)
    tv_show[:tmdb_id] = tv_show.delete(:id)
    tv_show[:created_at] = tv_show[:updated_at] = Time.now
    tv_show[:episode_run_time] = tv_show[:episode_run_time]&.first
    tv_show
  end
end
