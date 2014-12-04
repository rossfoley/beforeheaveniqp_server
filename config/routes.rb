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
    scope 'users' do
      post 'login', to: 'login#login'

      scope ':id' do
        put 'add_friend', to: 'users#add_friend'
        put 'remove_friend', to: 'users#remove_friend'
        get 'get_friends', to: 'users#get_friends'
        put 'current_room', to: 'users#update_current_room'
        get 'current_room', to: 'users#get_current_room'
        put 'is_online', to: 'users#update_is_online'
        get 'is_online', to: 'users#get_is_online'
      end
    end

    # Rooms
    resources :rooms, except: [:new, :edit] do
      member do
        get 'current_song'
        put 'add_band_member'
      end

      collection do
        get 'search/:search_term', to: 'rooms#search'
      end
    end
  end
end
