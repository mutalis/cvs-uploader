Rails.application.routes.draw do
  get 'orders/index'
  get '/orders/:id', to: 'orders#show', as: 'patient'
  post 'orders/import'

  root 'orders#index'
end
