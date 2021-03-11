class FetchEpisodes < CallTmdbApi
  extend Episodes

  def self.run(tmdb_id:, number_of_seasons:)
    endpoint_base = "tv/#{tmdb_id}?append_to_response="
    seasons_keys  = (1..number_of_seasons).map { |n| "season/#{n}"}
    endpoint      = endpoint_base + seasons_keys.join(',')
    data          = call(endpoint)
    episodes      = seasons_keys.map { |key| data[key.to_sym][:episodes] }.flatten
    episodes.map { |episode| set_attributes(episode) }
  end
end
