Rails.application.routes.draw do
  root 'health_check#ping'

  namespace :v1 do
    resources :restaurants
  end
end
