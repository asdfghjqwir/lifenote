Rails.application.routes.draw do

  devise_for :users
  root  'homes#top'
  get  'home/about', to: 'homes#about',as: 'about'
  resources :posts,only:[:index,:show,:create,:edit,:update,:destroy]
  resources :users, only:[:index,:show, :edit,:update]
end
