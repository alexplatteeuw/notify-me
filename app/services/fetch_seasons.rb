class FetchSeasons < CallTmdbApi
  extend Seasons

  def self.run(id)
    seasons = call("tv/#{id}")[:seasons]
    seasons.map! do |season|
      next if season[:season_number].zero?
      set_attributes(season)
    end
    seasons.compact
  end
end
