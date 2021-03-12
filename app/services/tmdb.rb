module Tmdb
  class Service
    include HTTParty
  
    def self.call(endpoint)
      response = get(URI.encode("#{BASE_URL}#{endpoint}".force_encoding('ASCII-8BIT')), headers: HEADERS)
      response.success? ? JSON.parse(response.body, symbolize_names: true) : {}
    end
    
    def self.popular_tv_shows
      tv_shows = call("tv/popular")[:results]
      tv_shows.map { |tv_show| Parser.new(response: tv_show, type: :tv_show_min).set_attributes }
    end
    
    def self.tv_shows_by_name(name)
      tv_shows = call("search/tv?query=#{name}")[:results]
      tv_shows.map { |tv_show| Parser.new(response: tv_show, type: :tv_show_max).set_attributes }
    end

    def self.tv_shows_by_id(id)
      tv_show = call("tv/#{id}")
      Parser.new(response: tv_show, type: :tv_show_max).set_attributes
    end
    
    def self.seasons_by_tv_show(id)
      seasons = call("tv/#{id}")[:seasons]
      seasons.select! { |season| !season[:season_number].zero? }
      seasons.map { |season| Parser.new(response: season, type: :seasons).set_attributes }
    end
    
    def self.episodes(tmdb_id:, number_of_seasons:)
      endpoint_base = "tv/#{tmdb_id}?append_to_response="
      seasons_keys  = (1..number_of_seasons).map { |n| "season/#{n}"}
      endpoint      = endpoint_base + seasons_keys.join(',')
      data          = call(endpoint)
      episodes      = seasons_keys.map { |key| data[key.to_sym][:episodes] }.flatten
      episodes.map { |episode| Parser.new(response: episode, type: :episodes).set_attributes }
    end
  end

  class Parser
    def initialize(attributes)
      @response = attributes[:response]
      @type = attributes[:type]
    end

    def set_attributes
      filter_attributes
      transform_attributes
    end
    
    def filter_attributes
      case @type
      when :tv_show_min 
        valid_keys = %i[id name poster_path vote_average]
      when :tv_show_max 
        valid_keys = %i[id name poster_path vote_average backdrop_path episode_run_time first_air_date number_of_seasons overview status tagline]
      when :seasons  
        valid_keys = %i[id air_date season_number name overview still_path vote_average episode_count]
      when :episodes 
        valid_keys = %i[id air_date episode_number name overview season_number still_path vote_average]
      end
      
      @response.slice!(*valid_keys)
    end
    
    def transform_attributes
      @response[:tmdb_id] = @response.delete(:id)
      @response[:created_at] = @response[:updated_at] = Time.now
      @response[:episode_run_time] = @response[:episode_run_time]&.first if @type == :tv_show_max
      @response
    end
  end
end