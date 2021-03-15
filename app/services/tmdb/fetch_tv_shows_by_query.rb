module Tmdb
  module FetchTvShowsByQuery
    def fetch_tv_shows_by(query:)
      endpoint = "search/tv?query=#{query}"
      call(endpoint)
    end
  end
end
