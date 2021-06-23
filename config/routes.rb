Rails.application.routes.draw do
  require 'sidekiq/web'
  # require 'sidekiq/cron/web'

  Rails.application.routes.draw do
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.credentials.dig(:sidekiq, :username))) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.credentials.dig(:sidekiq, :password)))
    end
    mount Sidekiq::Web, at: '/sidekiq'
  end

  resource :user, only: [:show, :update]
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :favorites, only: [:index]
  post 'fav/:tmdb_id', to: 'favorites#toggle', as: :toggle_favorite
  resources :tv_shows, param: :tmdb_id, only: [:show, :index] do
    resources :seasons, param: :season_number, only: [:show, :index]
  end
  get 'calendar', to: 'calendars#index'
  root to: 'tv_shows#index'
end
