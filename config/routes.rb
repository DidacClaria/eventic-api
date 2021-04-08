Rails.application.routes.draw do

   # define :users as the first devise mapping:
  mount_devise_token_auth_for 'User', at: 'auth'

  # define :admins as the second devise mapping. routes using this class will
  # need to be defined within a devise_scope as shown below
  mount_devise_token_auth_for "Company", at: 'company_auth'

 post 'crearevento', to:'eventos#create'
 get 'evento', to:'eventos#index'
 put 'evento/:id', to: 'eventos#update'
 get 'evento/:id', to: 'eventos#show'
 get 'eventocomp/:token', to: 'eventos#show_comp'
 delete 'evento/:id', to: 'eventos#destroy'
 resources :eventos
 resources :clients
end
