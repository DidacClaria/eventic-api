Rails.application.routes.draw do
  resources :event_tags
  resources :tags
  resources :eventos 
  get 'evento/comp', to:'eventos#comp', as: "comp_eventos"
  get 'evento', to:'eventos#index'
  put 'evento/:id', to: 'eventos#update'
  get 'evento/:id', to: 'eventos#show'
  get 'eventotag/:id', to: 'event_tags#show_tags'
  delete 'evento/:id', to: 'eventos#destroy'
  post 'crearevento', to:'eventos#create'
  get 'tagname/:id', to: 'tags#show_name'
  
  resources :users
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'

end
