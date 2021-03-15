module Tmdb::FetchEpisodes
  def fetch_episodes_by(tv_show:)
    endpoint_base      = "tv/#{tv_show.tmdb_id}?append_to_response="
    seasons_keys       = (1..tv_show.number_of_seasons).map { |n| "season/#{n}" }
    endpoint           = endpoint_base + seasons_keys.join(',')
    data               = call(endpoint)
    raw_attributes_set = seasons_keys.map { |key| data[key.to_sym][:episodes] }.flatten
    attributes_set = parse_collection(attributes_set: raw_attributes_set, selection: :episode)
  end
end
