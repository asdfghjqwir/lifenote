Rails.application.routes.draw do
 
  devise_for :users
  root 'homes#top'
  get 'home/about', to: 'homes#about', as: 'about'
  
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites,only: [:create, :destroy]
  end
  resources :favorites, only: [:index]


  resources :users, only: [:index, :show, :edit, :update,:destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get '/search', to: 'searches#search'

  
  devise_for :admin_users, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }
  
  namespace :admin  do
    resources :dashboard, only: [:index, :show, :destroy] 
  end
end