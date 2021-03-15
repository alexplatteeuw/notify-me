module Tmdb
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
