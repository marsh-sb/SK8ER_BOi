Rails.application.routes.draw do
  devise_for :users

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :posts, only: [:index,:show,:edit,:create,:destroy,:update]
  resources :users

end
