module Tmdb
  module FetchTvShowsByQuery
    def fetch_tv_shows_by(query:, page: 1)
      endpoint = "search/tv?query=#{query}&page=#{page}"
      call(endpoint)
    end
  end
end
