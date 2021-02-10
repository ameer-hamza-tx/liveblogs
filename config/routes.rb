Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  resources :articles do
  	resources :comments
  	collection do 
  		get 'mine'
  		get 'search'
  	end 
  end
 end
