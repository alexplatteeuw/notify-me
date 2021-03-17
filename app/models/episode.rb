class Episode < ApplicationRecord
  belongs_to :season
  validates :tmdb_id, presence: true, uniqueness: true
  
  scope :upcoming, -> { where("episodes.air_date > ?", Time.now).order(air_date: :asc) }
  scope :aired, -> { where("episodes.air_date < ?", Time.now).order(air_date: :asc) }
  scope :displayed_in_month_calendar,
        lambda { |start_date|
          where(air_date:
            start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
        }

  def start_time
    air_date
  end

  def tv_show_name
    season.tv_show_name
  end
end
