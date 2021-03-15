class TvShowsController < ApplicationController
  before_action :set_tv_show, only: [:show]

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

  def set_tv_show
    tv_show = TvShow.find_or_initialize_by(tmdb_id: params[:id])
    @tv_show = build_seasons_and_episodes(tv_show)
  end
end
