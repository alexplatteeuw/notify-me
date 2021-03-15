module Tmdb
  module FetchEpisodes
    def fetch_episodes_by(tv_show:)
      endpoint_base = "tv/#{tv_show.tmdb_id}?append_to_response="
      seasons_keys  = (1..tv_show.number_of_seasons).map { |n| "season/#{n}" }
      endpoint      = endpoint_base + seasons_keys.join(',')
      call(endpoint)
    end
  end
end
