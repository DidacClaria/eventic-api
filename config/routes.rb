Rails.application.routes.draw do

  resources :tags
  resources :eventos
  post 'crearevento', to:'eventos#create'
  get 'evento', to:'eventos#index'
  put 'evento/:id', to: 'eventos#update'
  get 'evento/:id', to: 'eventos#show'
  get 'eventocomp/:token', to: 'eventos#show_comp'
  delete 'evento/:id', to: 'eventos#destroy'


  resources :users
  post 'login', to: 'users#login'
  post 'logout', to: 'users#logout'

end
