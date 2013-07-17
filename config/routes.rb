InstallRails::Application.routes.draw do

  resources :sessions, only: :destroy
  resources :install_steps
  root 'welcome#index'

  delete '/signout', to: 'sessions#destroy'

end
