InstallRails::Application.routes.draw do
  resources :install_steps, path: 'steps'

  controller :main do
    get :test
    get :congratulations
  end

  root to: 'main#index'
end
