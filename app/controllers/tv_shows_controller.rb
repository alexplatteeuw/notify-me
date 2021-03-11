class TvShowsController < ApplicationController
  def index
    tv_shows_attributes = params[:query].present? ? FetchTvShowsByName.run(params[:query]) : FetchPopularTvShows.run
    tv_shows_ids = current_user.tv_shows.upsert_all(tv_shows_attributes, unique_by: :tmdb_id)
    @tv_shows = TvShow.find(tv_shows_ids.rows)
    if @tv_shows.present?
      @pagy, @tv_shows = pagy_array(@tv_shows, items: 20)
    else
      flash.now.alert = "Sorry, no TV shows found."
    end
  end

  def show
    @tv_show = set_tv_show(params[:id])
    # @notifications = current_user.notifications
    redirect_to root_path, notice: "Sorry, TV show not found." if @tv_show.blank?
  end
end
