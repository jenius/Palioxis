Palioxis::Application.routes.draw do

  root :to => 'users#index'
  devise_for :users, :path => 'account'

  resources :users do
    resources :goals
  end
  
end
