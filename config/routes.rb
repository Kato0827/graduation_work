Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home/index'
  resources :boards, only: %i[index new create show]
  resources :stone_records, only: %i[index new create show]
end
