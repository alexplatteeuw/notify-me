class TvShowsController < ApplicationController
  after_action :build_associations_in_jobs, only: [:index]
  before_action :build_tv_show_associations, only: [:show]

  def index
    if params[:query].present?
      json = Tmdb::Service.fetch_tv_shows_by(query: params[:query])
    else
      json = Tmdb::Service.fetch_popular_tv_shows
    end

    build_tv_shows(json) if json.present?

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

  def build_tv_shows(json)
    attributes   = Tmdb::Parser.run(json: json[:results], selection: TV_SHOW_MIN_ATTRIBUTES)
    tv_shows_ids = TvShow.upsert_all(attributes, unique_by: :tmdb_id)
    @tv_shows    = TvShow.find(tv_shows_ids.rows)
  end

  def build_associations_in_jobs
    @tv_shows.each { |tv_show| BuildTvShowAssociationsJob.perform_later(tv_show) }
  end
end
