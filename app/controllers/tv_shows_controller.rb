class TvShowsController < ApplicationController
  before_action :build_seasons_and_episodes, only: [:show]

  def index
    if params[:query].present?
      attributes = Tmdb::Service.fetch_tv_shows_by(query: params[:query])
    else
      attributes = Tmdb::Service.fetch_popular_tv_shows
    end

    @tv_shows = TvShow.bulk_create(attributes) if attributes.present?
      
    if @tv_shows.present? 
      @pagy, @tv_shows = pagy_array(@tv_shows, items: 20)
    else
      flash.now.alert = "Sorry, no TV shows found."
    end
  end
  
  def show
    redirect_to root_path, notice: "Sorry, TV show not found." if @tv_show.blank?
  end
  
  private

  def build_seasons_and_episodes
    set_tv_show
    @tv_show = @tv_show.update_with_all_attributes
    attributes = Tmdb::Service.fetch_seasons_by(tv_show: @tv_show)
    seasons = Season.bulk_create(tv_show: @tv_show, attributes: attributes)
    attributes = Tmdb::Service.fetch_episodes_by(tv_show: @tv_show)
    seasons.each { |season| Episode.bulk_create(season: season, attributes: attributes) }
  end
  
  def set_tv_show
    @tv_show = TvShow.find_or_initialize_by(tmdb_id: params[:id])
  end
end
