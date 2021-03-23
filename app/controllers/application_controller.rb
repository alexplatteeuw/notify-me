class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  def set_tv_show
    @tv_show = TvShow.find_or_initialize_by(tmdb_id: params[:tmdb_id])
  end

  def build_tv_show_associations
    set_tv_show
    TvShows::BuildAssociations.run(@tv_show)
  end
end
