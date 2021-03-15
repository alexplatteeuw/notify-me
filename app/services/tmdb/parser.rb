module Tmdb
  class Parser
    def initialize(json:, selection:)
      @selection = selection
      @json = prepare_json(json)
    end

    def self.run(json:, selection:)
      new(json: json, selection: selection).set_attributes
    end

    def set_attributes
      case @json
      when Hash
        perform_changes(@json)
      when Array
        @json.map { |json| perform_changes(json) }.compact
      end
    end

    def perform_changes(json)
      filter_attributes(json)
      transform_attributes(json)
      filter_elements(json)
    end

    def filter_attributes(json)
      json.slice!(*@selection)
    end

    def transform_attributes(json)
      json[:tmdb_id] = json.delete(:id)
      json[:created_at] = json[:updated_at] = Time.now
      json[:episode_run_time] = json[:episode_run_time]&.first if @selection == :tv_show_max
    end

    def filter_elements(json)
      @selection == :season && json[:season_number].zero? ? nil : json
    end

    def prepare_json(json)
      case @selection
      when PERSON_ATTRIBUTES then json[:credits][:cast].dup
      when SEASON_ATTRIBUTES then json[:seasons].dup
      when EPISODE_ATTRIBUTES then json
                                    .extend(Hashie::Extensions::DeepFind)
                                    .deep_select(:episodes)
                                    .flatten
      else 
        json.dup
      end
    end
  end
end
