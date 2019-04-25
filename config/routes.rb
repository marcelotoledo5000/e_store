Rails.application.routes.draw do
  resources :products, except: [:new]
  resources :customers, except: [:destroy, :new]
  resources :orders, except: [:destroy, :new]
  resources :reports, only: [:get] do
    get :average_ticket, on: :collection
  end
end
