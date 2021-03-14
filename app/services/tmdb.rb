module Tmdb
  class Service
    include HTTParty
    extend TvShows, Seasons, Episodes
  
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

  class Parser
    def initialize(attributes:, selection:)
      @attributes = attributes
      @selection  = selection
    end

    def set_attributes
      filter_attributes
      transform_attributes
    end
    
    def filter_attributes
      case @selection
      when :minimum 
        valid_keys = %i[id name poster_path vote_average]
      when :maximum 
        valid_keys = %i[id name poster_path vote_average backdrop_path episode_run_time first_air_date number_of_seasons overview status tagline]
      when :season
        valid_keys = %i[id air_date season_number name overview still_path vote_average episode_count]
      when :episode
        valid_keys = %i[id air_date episode_number name overview season_number still_path vote_average]
      end
      @attributes.slice!(*valid_keys)
    end
    
    def transform_attributes
      @attributes[:tmdb_id] = @attributes.delete(:id)
      @attributes[:created_at] = @attributes[:updated_at] = Time.now
      @attributes[:episode_run_time] = @attributes[:episode_run_time]&.first if @selection == :maximum
      @attributes
    end
  end
end
