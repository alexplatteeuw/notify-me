class CalendarsController < ApplicationController
  def index
    start_date = params.fetch(:start_date, Date.current).to_date
    
    if params[:selected_date].nil? && start_date.year == Date.current.year && start_date.month == Date.current.month
      @selected_date = Date.current
    elsif params[:selected_date].nil?
      nil
    else
      @selected_date = params[:selected_date].to_date
    end

    @tv_shows  = current_user.favorited_by_type('TvShow')
    @episodes  = @tv_shows.map { |tv_show| tv_show.episodes.displayed_in_month_calendar(start_date) }.flatten
    @selected_episodes = @episodes.select { |episode| episode.air_date == @selected_date }
  end
end
