Rails.application.routes.draw do
  root 'home#index'
  resources :deal_items, only: [:index]
end
