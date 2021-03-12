class Episode < ApplicationRecord
  belongs_to :season
  
  scope :upcoming, -> { where("episodes.air_date > ?", Time.now).order(air_date: :asc) }
  scope :aired, -> { where("episodes.air_date < ?", Time.now).order(air_date: :asc) } 
  
  def start_time
    air_date
  end
  
  def tv_show_name
    season.tv_show_name
  end
end
