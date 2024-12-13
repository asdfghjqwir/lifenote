Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about', to: 'homes#about', as: 'about'
  
  resources :posts, only: [:index, :show, :create, :edit, :update, :destroy] do
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update,:destroy]

  get '/search', to: 'searches#search'

  scope :admin do
    get 'login', to: 'admin_sessions#new',as: :admin_login
    post 'login', to: 'admin_sessions#create'
    delete 'logout', to: 'admin_sessions#destroy', as: :admin_logout
    get 'dashboard', to: 'admins#dashboard', as: :admin_dashboard
    
    get '/users/:id', to: 'admins#show', as: :admin_user
    delete '/users/:id', to: 'admins#destroy', as: :delete_admin_user
   
  end
end
