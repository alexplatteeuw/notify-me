class BuildTvShowAssociationsJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: false

  def perform(tv_show)
    TvShows::BuildAssociations.run(tv_show)
  end
end
