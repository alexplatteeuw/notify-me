class FetchTvShowById < CallTmdbApi
  extend FavoritedTvShows

  def self.run(id)
    tv_show = call("tv/#{id}")
    set_attributes(tv_show)
  end
end
