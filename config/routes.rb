Rails.application.routes.draw do
  devise_for :users
  resources :logs do
  	collection { post :import }
	end
  root "logs#index"
  
end
