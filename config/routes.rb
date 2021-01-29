Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  resources :articles do
  	resources :comments
  	get 'articles/mine' , on: :collection

  end
 end
