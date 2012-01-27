Palioxis::Application.routes.draw do

  root :to => 'users#index'
  devise_for :users

  match '/users/:id/add_card' => 'users#add_card', :as => 'add_card'
  match '/users/:id/edit_card' => 'users#edit_card', :as => 'edit_card'
  match '/users/:id/charge_card' => 'users#charge_card', :as => 'charge_card'
  match '/donate' => 'users#donate', :as => 'donate'

  resources :users do
    resources :goals
  end
  
end
