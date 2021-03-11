module Episodes
  def set_attributes(episode)
    episode_filtered = filter_attributes(episode)
    transform_attributes(episode_filtered)
  end

  def filter_attributes(episode)
    valid_keys = %i[id air_date episode_number name overview season_number still_path vote_average]
    episode.slice!(*valid_keys)
    episode
  end

  def transform_attributes(episode)
    episode[:tmdb_id] = episode.delete(:id)
    episode[:created_at] = episode[:updated_at] = Time.now
    episode
  end
end
