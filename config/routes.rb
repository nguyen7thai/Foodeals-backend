Rails.application.routes.draw do
  # root 'welcome#index'
  resources :deal_items, only: [:index]
end
