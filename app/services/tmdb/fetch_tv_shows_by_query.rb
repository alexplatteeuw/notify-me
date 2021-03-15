module Tmdb::FetchTvShowsByQuery
  def fetch_tv_shows_by(query:)
    endpoint           = "search/tv?query=#{query}"
    raw_attributes_set = call_api_for_tv_shows(endpoint)
    attributes_set     = parse_collection(attributes_set: raw_attributes_set, selection: :maximum)
    attributes_set
  end
end
