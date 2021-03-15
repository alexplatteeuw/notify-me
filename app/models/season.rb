class Season < ApplicationRecord
  belongs_to :tv_show
  has_many :episodes, dependent: :destroy

  validates :tmdb_id, presence: true, uniqueness: true

  def tv_show_name
    tv_show.name
  end
end
