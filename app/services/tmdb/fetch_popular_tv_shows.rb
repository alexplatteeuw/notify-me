module Tmdb::FetchPopularTvShows
  def fetch_popular_tv_shows
    endpoint           = "tv/popular"
    raw_attributes_set = call(endpoint)[:results]
    attributes_set     = parse_collection(attributes_set: raw_attributes_set, selection: :minimum)
    attributes_set
  end
end
