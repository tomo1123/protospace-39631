Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "prototypes#index"
  
  resources :prototypes do [:index, :new, :create, :show, :edit, :update, :destroy]
     resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  
end
