Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'merchants#find_all'
      get '/revenue/merchants', to: 'revenue#merchants'
      get '/revenue/items', to: 'revenue#items'
      get '/revenue/merchants/:merchant_id', to: 'revenue#merchant'
      get '/revenue/unshipped', to: 'revenue#unshipped'
      get '/revenue/weekly', to: 'revenue#weekly'
      get '/revenue', to: 'revenue#date_range'
      get '/merchants/most_items', to: 'revenue#most_items'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
      get '/items/find', to: 'items#find'
      resources :items do
        resource :merchant, only: [:show]
      end
    end
  end
end
