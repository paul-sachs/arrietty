Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :products

  resource :preference, path: :preferences

  get '/my_products' => 'products#my_products'

  devise_scope :user do
    match '/twitter_sign_up' =>
        'users/omniauth_callbacks#twitter_submit', via: [:post, :patch]
  end

  root to: 'products#index'

  get '/locate_me' => 'preferences#locate_me'
end