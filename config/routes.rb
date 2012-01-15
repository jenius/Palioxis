Palioxis::Application.routes.draw do

  resources :tests

  root :to => 'users#index'
  resources :users
  
end
