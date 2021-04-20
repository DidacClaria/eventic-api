Rails.application.routes.draw do

  resources :eventos 
  get 'evento/comp', to:'eventos#comp', as: "comp_eventos"
  get 'evento', to:'eventos#index'
  put 'evento/:id', to: 'eventos#update'
  get 'evento/:id', to: 'eventos#show'
  delete 'evento/:id', to: 'eventos#destroy'
  post 'crearevento', to:'eventos#create'

  resources :followers
  post 'afegirfollower', to: 'followers#create' 

  resources :users
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'

end
