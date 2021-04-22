Rails.application.routes.draw do

  resources :event_tags
  resources :tags
  resources :eventos
  post 'crearevento', to:'eventos#create'
  get 'evento', to:'eventos#index'
  put 'evento/:id', to: 'eventos#update'
  get 'evento/:id', to: 'eventos#show'
  get 'eventocomp/:token', to: 'eventos#show_comp'
  get 'eventotag/:id', to: 'event_tags#show_tags'
  delete 'evento/:id', to: 'eventos#destroy'
  get 'tagname/:id', to: 'tags#show_name'

  resources :users
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'

end
