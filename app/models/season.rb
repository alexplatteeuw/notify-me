class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy
  
  def tv_show_name
    tv_show.name
  end
end
