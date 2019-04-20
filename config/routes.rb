Rails.application.routes.draw do
  resources :products, except: [:new]
  resources :customers, except: [:destroy, :new]
end
