Palioxis::Application.routes.draw do

  root :to => 'users#index'
  devise_for :users, :path => 'account', :controllers => { :registrations => "registrations" }

  match '/users/:id/add_card' => 'users#add_card', :as => 'add_card'

  resources :users do
    resources :goals
  end
  
end
