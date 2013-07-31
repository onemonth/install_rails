InstallRails::Application.routes.draw do

  resources :sessions, only: :destroy
  resources :install_steps
  root 'welcome#index'

  get 'test', to: 'welcome#test'
  delete 'signout', to: 'sessions#destroy'

end
