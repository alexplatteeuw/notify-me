class CleanTvShows < ActiveJob::Base
  queue_as :default

  def perform
    ids = TvShow.pluck(:id) - Favorite.favorite_list.pluck(:favoritable_id)
    TvShow.destroy(ids)
  end
end
