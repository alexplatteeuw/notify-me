class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  def build_tv_show_associations
    @tv_show = TvShow.find_or_initialize_by(tmdb_id: params[:id])
    return if @tv_show.has_seasons_and_episodes? && @tv_show.updated_in_the_last?(6.hours)

    TvShows::BuildAssociations.run(@tv_show)
  end
end
