module TvShows
  class BuildAssociations
    def self.run(tv_show)
      tv_show_json = Tmdb::Service.fetch_tv_show_by(tmdb_id: tv_show.tmdb_id)
      tv_show = update_tv_show(tv_show_json)

      build_seasons(tv_show_json, tv_show)
      build_people(tv_show_json, tv_show)

      episodes_json = Tmdb::Service.fetch_episodes_by(tv_show: tv_show)
      build_episodes(episodes_json, tv_show)
    end

    def self.update_tv_show(json)
      attributes = Tmdb::Parser.run(json: json, selection: TV_SHOW_MAX_ATTRIBUTES)
      tv_show_id = TvShow.upsert(attributes, unique_by: :tmdb_id)
      TvShow.find(tv_show_id.rows).first
    end

    def self.build_seasons(json, tv_show)
      attributes = Tmdb::Parser.run(json: json, selection: SEASON_ATTRIBUTES)
      tv_show.seasons.upsert_all(attributes, unique_by: :tmdb_id) if attributes.present?
    end

    def self.build_people(json, tv_show)
      attributes  = Tmdb::Parser.run(json: json, selection: PERSON_ATTRIBUTES)
      tv_show.people.upsert_all(attributes, unique_by: :tmdb_id) if attributes.present?
    end

    def self.build_episodes(json, tv_show)
      episodes_attributes = Tmdb::Parser.run(json: json, selection: EPISODE_ATTRIBUTES)

      tv_show.seasons.each do |season|
        attributes = episodes_attributes
                      .extend(Hashie::Extensions::DeepLocate)
                      .deep_locate lambda { |k, v, _object| k == :season_number && v == season.season_number }
        season.episodes.upsert_all(attributes, unique_by: :tmdb_id) if attributes.present?
      end
    end
  end
end
