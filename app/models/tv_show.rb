class TvShow < ApplicationRecord
  acts_as_favoritable

  belongs_to :user
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons

  def returning?
    status == "Returning"
  end
end
