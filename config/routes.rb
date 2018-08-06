Rails.application.routes.draw do
  resources :charges, only: [:new, :create]
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end
  get 'about' => 'welcome#about'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
