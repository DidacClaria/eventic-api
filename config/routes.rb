Rails.application.routes.draw do


  resources :messages
  resources :chats
  resources :favourites
  resources :entrada_usuarios
  resources :event_tags
  resources :tags
  resources :eventos
  post '/follower', to:'followers#create'
  get 'evento_comp/:id_creator', to:'eventos#comp'
  get 'evento', to:'eventos#index'
  put 'evento/:id', to: 'eventos#update'
  get 'evento/:id', to: 'eventos#show'
  get 'eventotag/:id', to: 'event_tags#show_tags'
  delete 'evento/:id', to: 'eventos#destroy'
  post 'crearevento', to:'eventos#create'
  get 'user_chats', to: 'chats#user_chats'
  get 'chat_messages', to: 'messages#chat_messages'


  resources :followers
  delete '/follower', to: 'followers#destroy'


  get 'entrada_usuarios/:id', to:'entrada_usuarios#show'
  get 'entrada_usuarios', to:'entrada_usuarios#index'
  post 'entrada_usuarios', to:'entrada_usuarios#create'
  delete 'entrada_usuarios', to:'entrada_usuarios#destroy'
  get 'part_evento/:evento_id', to: 'entrada_usuarios#show_tickets_event'

  post 'favourites', to: 'favourites#create'
  delete 'favourites', to: 'favourites#destroy'
  get 'like_event', to:'favourites#show'

  resources :users
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'

end
