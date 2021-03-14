module Seasons
  def fetch_seasons_by(tv_show:)
    endpoint = "tv/#{tv_show.tmdb_id}"
    raw_attributes_set = call(endpoint)[:seasons]
    raw_attributes_set.reject! { |attributes| attributes[:season_number].zero? }
    attributes_set = parse_collection(attributes_set: raw_attributes_set, selection: :season)
    attributes_set
  end
end
