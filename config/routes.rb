Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home/index'
  resources :boards, only: %i[index new create show]
end
