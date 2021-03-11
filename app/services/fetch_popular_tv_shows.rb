class FetchPopularTvShows < CallTmdbApi
  extend UnfavoritedTvShows

  def self.run
    tv_shows = call("tv/popular")[:results]
    tv_shows.map { |tv_show| set_attributes(tv_show) }
  end
end
