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
    post 'user/login' => 'user#login'
    get 'rooms' => 'room#index'
    post 'room' => 'room#create'
    put 'room/:room_id/add_band_member/:new_member_email', to: 'room#add_band_member', format: false, constraints: { new_member_email: /[^\/]+/}
  end
end
