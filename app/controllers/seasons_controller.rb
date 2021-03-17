class SeasonsController < ApplicationController
  before_action :find_tv_show, only: %i[index show]

  def index
    @seasons = @tv_show.seasons
  end

  def show
    @season = @tv_show.seasons.find_by_season_number(params[:season_number])
  end

  private

  def find_tv_show
    @tv_show = TvShow.find_by_tmdb_id(params[:tv_show_tmdb_id])
  end
end
