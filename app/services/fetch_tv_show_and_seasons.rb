 module Tmdb::FetchTvShowAndSeasons
  def fetch_tv_show_and_seasons_by(tmdb_id:)
    endpoint = "tv/#{tmdb_id}"
    raw_attributes_set = call(endpoint)[:seasons]
    raw_attributes_set.reject! { |attributes| attributes[:season_number].zero? }
    attributes_set = parse_collection(attributes_set: raw_attributes_set, selection: :season)
    attributes_set
  end
end
