class TvShowsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  after_action :build_associations_in_jobs, only: [:index]
  before_action :build_tv_show_associations, only: [:show]

  def index
    if params[:query].present?
      json = Tmdb::Service.fetch_tv_shows_by(query: params[:query], page: params[:page])
    else
      json = Tmdb::Service.fetch_popular_tv_shows(page: params[:page])
    end

    build_tv_shows(json) if json.present? && !json[:results].empty?

    if @tv_shows.present?
      @pagy = Pagy.new(count: json[:total_results], page: params[:page])
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
    @tv_shows.each { |tv_show| BuildTvShowAssociationsJob.perform_later(tv_show) } if @tv_shows
  end
end
