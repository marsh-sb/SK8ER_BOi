Rails.application.routes.draw do
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  get "search" => "users#search"

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users
  resources :parks

end
