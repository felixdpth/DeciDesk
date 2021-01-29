Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :report

  resource :treasury, only: :show do
    resources :comments, only: [:new, :create]
  end

  resource :sales, only: :show do
    resources :comments, only: [:new, :create]
  end

  resource :expenditure, only: :show do
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [:edit, :update, :destroy]
  # do
  #   resources :comments
  #   resources :lines
  # end

end
