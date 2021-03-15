class TvShowsController < ApplicationController
  after_action :set_tv_shows, only: [:index]
  before_action :set_tv_show, only: [:show]

  def index
    if params[:query].present?
      json = Tmdb::Service.fetch_tv_shows_by(query: params[:query])
    else
      json = Tmdb::Service.fetch_popular_tv_shows
    end

    if json.present?
      attributes = Tmdb::Parser.run(json: json[:results], selection: TV_SHOW_MIN_ATTRIBUTES)
      tv_shows_ids = TvShow.upsert_all(attributes, unique_by: :tmdb_id)
      @tv_shows = TvShow.find(tv_shows_ids.rows)
    end

    if @tv_shows.present?
      @pagy, @tv_shows = pagy_array(@tv_shows, items: 20)
    else
      flash.now.alert = "Sorry, no TV shows found."
    end
  end

  def show
    redirect_to root_path, notice: "Sorry, TV show not found." if @tv_show.blank?
  end

  def set_tv_shows
    @tv_shows.each do |tv_show|
      next if tv_show.seasons.present? && tv_show.episodes.present? && tv_show.updated_at > Time.now - 6.hours
      BuildTvShowAssociationsJob.perform_later(tv_show)
    end
  end

  def set_tv_show
    @tv_show = TvShow.find_or_initialize_by(tmdb_id: params[:id])
    return if @tv_show.seasons.present? && @tv_show.episodes.present? && @tv_show.updated_at > Time.now - 6.hours
    TvShows::BuildAssociations.run(@tv_show)
    @tv_show = TvShow.find_or_initialize_by(tmdb_id: params[:id])
  end
end
