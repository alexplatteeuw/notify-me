class SeasonsController < ApplicationController
  before_action :find_tv_show, only: %i[index show]

  def index
    @pagy, @seasons = pagy(@tv_show.seasons, items: 10)
  end

  def show
    @season = @tv_show.seasons.find_by_season_number(params[:season_number])
    @pagy, @episodes = pagy(@season.episodes.order(episode_number: :asc), items: 10)
  end

  private

  def find_tv_show
    @tv_show = TvShow.find_by_tmdb_id(params[:tv_show_tmdb_id])
  end
end
