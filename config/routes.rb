Rails.application.routes.draw do
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
  end
end
