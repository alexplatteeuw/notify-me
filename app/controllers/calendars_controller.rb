class CalendarsController < ApplicationController
  def index
    @tv_shows = current_user.favorited_by_type('TvShow')
    @episodes = @tv_shows.map(&:upcoming_episodes).flatten
  end
end
