module Tmdb
  module FetchPopularTvShows
    def fetch_popular_tv_shows(page: 1)
      endpoint = "tv/popular?page=#{page}"
      call(endpoint)
    end
  end
end
