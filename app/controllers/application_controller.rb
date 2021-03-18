class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  def build_tv_show_associations
    @tv_show = TvShow.find_or_initialize_by(tmdb_id: params[:tmdb_id])
    TvShows::BuildAssociations.run(@tv_show)
  end
end



  



    