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
    post 'user/login', to: 'user#login'
    get 'rooms', to: 'room#index'
    get 'room/:room_id/current_song', to: 'room#current_song'
    post 'room', to: 'room#create'
    put 'room/:room_id/add_band_member/:new_member_email', 
        to: 'room#add_band_member', 
        format: false, 
        constraints: { new_member_email: /[^\/]+/}
  end
end
