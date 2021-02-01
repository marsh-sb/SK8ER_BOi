Rails.application.routes.draw do
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users

end
