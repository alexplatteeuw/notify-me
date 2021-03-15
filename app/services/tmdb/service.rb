module Tmdb
  class Service
    include HTTParty
    extend FetchPopularTvShows, FetchTvShowsByQuery, FetchTvShow, FetchSeasons, FetchEpisodes

    def self.call(endpoint)
      response = get(URI.encode("#{BASE_URL}#{endpoint}".force_encoding('ASCII-8BIT')), headers: HEADERS)
      response.success? ? JSON.parse(response.body, symbolize_names: true) : {}
    end

    def self.parse_collection(attributes_set:, selection:)
      attributes_set.map { |attributes| parse(attributes: attributes, selection: selection) }
    end

    def self.parse(attributes:, selection:)
      Parser.new(attributes: attributes, selection: selection).set_attributes
    end
  end
end
