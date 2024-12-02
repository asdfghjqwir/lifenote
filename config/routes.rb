Rails.application.routes.draw do

  devise_for :users
  root  'homes#top'
  get  'home/about', to: 'homes#about',as: 'about'
  resources :posts,only:[:index,:show,:create,:edit,:update,:destroy] do
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only:[:index,:show, :edit,:update]
   get '/search', to: 'searches#search'
end
