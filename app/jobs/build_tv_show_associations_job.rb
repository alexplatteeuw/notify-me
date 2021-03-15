class BuildTvShowAssociationsJob < ApplicationJob
  queue_as :default

  def perform(tv_show)
    TvShows::BuildAssociations.run(tv_show)
  end
end
