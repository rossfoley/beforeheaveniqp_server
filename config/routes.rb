Rails.application.routes.draw do
  match '*path' => 'application#cors_preflight_check', via: :options, constraints: {method: 'OPTIONS'}
  
  devise_for :users

  # SoundCloud account linking
  get 'soundcloud/index', as: :soundcloud
  get 'soundcloud/authorize', as: :soundcloud_authorize
  get 'soundcloud/callback', as: :soundcloud_callback

  get 'home/index'
  root 'home#index'
  
  # API Endpoints
  namespace :api do
    # Users
    scope 'user' do
      post 'login', to: 'login#login'

      scope ':id' do
        put 'add_friend', to: 'user#add_friend'
      end
    end

    # Rooms
    resources :rooms, except: [:new, :edit] do
      member do
        get 'current_song'
        get 'add_band_member'
      end

      collection do
        get 'search/:search_term', to: 'room#search'
      end
    end
  end
end
