Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :reports do
    resources :comments, only: [:new, :create]
    get '/expenditure', to: 'expenditures#show'
    get '/sales', to: 'sales#show'
    get '/treasury', to: 'treasuries#show'
  end

resources :comments, only: [:edit, :update, :destroy]
end
