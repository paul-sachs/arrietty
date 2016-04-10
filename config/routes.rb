Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: "users/registrations"
  }
  resources :products
  get '/products/:id/contact_form', to: 'products#contact_form', as: 'contact_owner_form'
  post '/products/:id/contact', to: 'products#contact' , as: 'contact_owner'

  resource :preference, path: :preferences

  get '/my_products' => 'products#my_products'
  
  devise_scope :user do
    match '/twitter_sign_up' =>
        'users/omniauth_callbacks#twitter_submit', via: [:post, :patch]
  end

  root to: 'products#index'

  get '/locate_me' => 'preferences#locate_me'
end