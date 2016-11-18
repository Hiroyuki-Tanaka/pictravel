Rails.application.routes.draw do
  devise_for :users

  root 'picture#index'
  resources :picture
  resources :user
  resources :comment

end
