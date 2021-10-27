Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'merchants/find_all', to: 'merchants#find_all'
      resources :merchants, only: [:index, :show]
      resources :items
    end
  end
end
