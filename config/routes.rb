Rails.application.routes.draw do
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
