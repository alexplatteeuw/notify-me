class CalendarsController < ApplicationController
  def index
    start_date = params.fetch(:start_date, Date.current).to_date
    @selected_date = params[:selected_date] ? params[:selected_date].to_date : nil
    @tv_shows  = current_user.favorited_by_type('TvShow')
    @episodes  = @tv_shows.map { |tv_show| tv_show.episodes.displayed_in_month_calendar(start_date) }.flatten
    @selected_episodes = @episodes.select { |episode| episode.air_date == @selected_date }
  end
end
