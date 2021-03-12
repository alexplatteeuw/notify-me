class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  def set_tv_show(tmdb_id)
    tv_show_attribute  = Tmdb::Service.tv_shows_by_id(tmdb_id)
    tv_show_id = current_user.tv_shows.upsert(tv_show_attribute, unique_by: :tmdb_id)
    TvShow.find(tv_show_id.rows).first
  end
end
