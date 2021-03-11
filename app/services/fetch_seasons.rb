class FetchSeasons < CallTmdbApi
  extend Seasons

  def self.run(id)
    seasons = call("tv/#{id}")[:seasons]
    seasons.map { |season| set_attributes(season) } 
  end
end
