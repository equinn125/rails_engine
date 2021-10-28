Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'revenue/merchants/:id', to: 'revenue#total_merchant_revenue'
      get 'merchants/find_all', to: 'merchants#find_all'
      get 'items/find', to: 'items#find'
      resources :merchants, only: [:index, :show]
      resources :items
    end
  end
end
