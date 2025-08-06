Rails.application.routes.draw do
  devise_for :users
  root to: 'tasks#new'
  resources :tasks, only: [:new, :create]
end
