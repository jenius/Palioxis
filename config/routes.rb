Palioxis::Application.routes.draw do

  root :to => 'users#index'
  devise_for :users

  match '/manage_card' => 'users#manage_card', :as => 'manage_card'
  match '/edit_card' => 'users#edit_card', :as => 'edit_card'
  
  match '/donate' => 'users#donate', :as => 'donate'
  match '/users/:id/charge_card' => 'users#charge_card', :as => 'charge_card' # dangerous, revise this

  match '/goals/:id/complete' => 'goals#mark_complete', :as => 'complete_goal'
  match '/goals/:id/fail' => 'goals#mark_failed', :as => 'fail_goal'

  resources :users do
    resources :goals
  end
  
end
