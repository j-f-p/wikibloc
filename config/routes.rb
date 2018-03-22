Rails.application.routes.draw do
  resources :charges, only: [:new, :create]
  devise_for :users, :controllers => { :registrations => "role" }
  resources :wikis
  get 'about' => 'welcome#about'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
