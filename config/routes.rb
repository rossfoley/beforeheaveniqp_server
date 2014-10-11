Rails.application.routes.draw do
  get 'soundcloud/index', as: :soundcloud

  get 'soundcloud/authorize', as: :soundcloud_authorize

  get 'soundcloud/callback', as: :soundcloud_callback

  get 'home/index'

  devise_for :users

  root 'home#index'
end
