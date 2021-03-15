class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  def build_seasons_and_episodes(tv_show)
    tv_show    = tv_show.update_with_all_attributes
    attributes = Tmdb::Service.fetch_seasons_by(tv_show: tv_show)
    seasons    = Season.bulk_create(tv_show: tv_show, attributes: attributes)
    attributes = Tmdb::Service.fetch_episodes_by(tv_show: tv_show)
    seasons.each { |season| Episode.bulk_create(season: season, attributes: attributes) }
    tv_show
  end
end
