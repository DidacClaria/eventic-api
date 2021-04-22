Rails.application.routes.draw do

  resources :entrada_usuarios
  resources :eventos 
  get 'evento/comp', to:'eventos#comp', as: "comp_eventos"
  get 'evento', to:'eventos#index'
  put 'evento/:id', to: 'eventos#update'
  get 'evento/:id', to: 'eventos#show'
  delete 'evento/:id', to: 'eventos#destroy'
  post 'crearevento', to:'eventos#create'

  get 'entrada_usuarios/:eventid', to:'entrada_usuarios#show_ticket_event'
  get 'entrada_usuarios/:id', to:'entrada_usuarios#show'
  get 'entrada_usuarios', to:'entrada_usuarios#index'
  post 'crearentrada_usuarios', to:'entrada_usuarios#create'
  

  resources :users
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'

end
