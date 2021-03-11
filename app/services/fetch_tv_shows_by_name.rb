class FetchTvShowsByName < CallTmdbApi
  extend UnfavoritedTvShows

  def self.run(name)
    tv_shows = call("search/tv?query=#{name}")[:results]
    tv_shows.map { |tv_show| set_attributes(tv_show) }
  end
end
