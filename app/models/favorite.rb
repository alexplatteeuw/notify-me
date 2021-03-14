class Favorite < ApplicationRecord
  extend ActsAsFavoritor::FavoriteScopes
  # after_save { SeasonsAndEpisodesCreatorJob.perform_later(favoritable_type, favoritable_id) }

  belongs_to :favoritable, polymorphic: true
  belongs_to :favoritor, polymorphic: true

  def block!
    update!(blocked: true)
  end
end
