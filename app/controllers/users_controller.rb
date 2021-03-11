class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def show
    # @notifications = current_user.notifications
    # @favorites = current_user.favorites
    #                          .to_tv_shows.select(&:returning?)
    #                          .map { |tv_show| current_user.favorites.find_by(tmdb_id: tv_show.id) }
  end

  def update
    if @user.update(user_params)
      flash.now.notice = "Avatar successfully changed."
    else
      flash.now.alert = "Sorry, unable to change avatar."
    end
    render :show
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:avatar)
  end
end
