Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root to: "pages#home"
  root to: "pages#home"
  get 'components', to: 'pages#components'
  get 'navbar', to: 'pages#navbar'
  resources :reports, only: [:new, :create, :show] do
    resources :feedbacks, only: [:index, :create]
  end
end
