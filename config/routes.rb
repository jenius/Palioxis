Palioxis::Application.routes.draw do

  root :to => 'users#index'
  devise_for :users

  # changing user credit card info
  match '/manage_card' => 'users#manage_card', :as => 'manage_card'
  match '/edit_card' => 'users#edit_card', :as => 'edit_card'
  
  # charging user cards
  match '/donate' => 'users#donate', :as => 'donate'
  match '/users/:id/charge_card' => 'users#charge_card', :as => 'charge_card' # dangerous, revise this

  # making goals as complete or not
  match '/goals/:id/complete' => 'goals#mark_complete', :as => 'complete_goal'
  match '/goals/:id/fail' => 'goals#mark_failed', :as => 'fail_goal'

  # pages that don't fit a controller
  match '/introduction' => 'pages#intro', :as => 'intro'

  resources :users do
    resources :goals
  end
  
end
