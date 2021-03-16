class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:toggle]

  def index
    @favorites = current_user.favorited_by_type('TvShow')
    @favorites = @favorites.where(status: params[:status]) if params[:status].present?
    @pagy, @favorites = pagy_array(@favorites, items: 6)
  end

  def toggle
    current_user.favorited?(@favorite) ? remove_favorite : add_favorite
    render template: 'shared/toggle_favorite', locals: { type: :tv_show }
  end

  private

  def add_favorite
    if current_user.favorite(@favorite)
      flash.now.notice = "Successfully added to your favourites."
    else
      flash.now.alert = "Sorry, can't add favorite."
    end
  end

  def remove_favorite
    if current_user.unfavorite(@favorite)
      flash.now.notice = "Successfully removed from your favourites."
    else
      flash.now.alert = "Sorry, can't remove favorite."
    end
  end

  def set_favorite
    if params[:type] == 'tv_show'
      build_tv_show_associations
      @favorite = @tv_show
    end
  end
end
