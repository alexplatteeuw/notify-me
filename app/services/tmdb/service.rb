module Tmdb
  class Service
    include HTTParty
    extend FetchEpisodes
    extend FetchTvShow
    extend FetchTvShowsByQuery
    extend FetchPopularTvShows

    def self.call(endpoint)
      response = get(URI.encode("#{BASE_URL}#{endpoint}".force_encoding('ASCII-8BIT')), headers: HEADERS)
      response.success? ? JSON.parse(response.body, symbolize_names: true) : {}
    end
  end
end
