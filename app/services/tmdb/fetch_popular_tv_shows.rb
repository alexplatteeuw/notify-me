module Tmdb
  module FetchPopularTvShows
    def fetch_popular_tv_shows
      endpoint = "tv/popular"
      call(endpoint)
    end
  end
end
