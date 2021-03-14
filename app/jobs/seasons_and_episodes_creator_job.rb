class SeasonsAndEpisodesCreatorJob < ApplicationJob
  queue_as :default

  def perform(tv_show)
    tv_show.create_seasons_and_episodes
  end
end
