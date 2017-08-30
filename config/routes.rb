Rails.application.routes.draw do


  resources :categorizations
  resources :categories
  get "signin" => "sessions#new"

  resource :session

  get "signup" => "users#new"

  resources :users
  root "events#index"

  resources :events do
    resources :registrations
    resources :likes
  end


end
