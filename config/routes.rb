Rails.application.routes.draw do
  resources :places
  devise_for :users

  root 'pictures#index'
  resources :pictures do
      collection do
      get 'search'
    end
   resources :comments
  end
  resources :users

  get 'pictures/search_output/test' => 'pictures#search_output'

end

