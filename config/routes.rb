Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :reports do
    resources :comments, only: [:new, :create]
    get '/expenditures', to: 'expenditures#show'
    get '/expenditures/advice', to: 'expenditures#advice'
    get '/expenditures/comments', to: 'expenditures#comments'
    get '/expenditures/transactions', to: 'expenditures#transactions'
    get '/treasury', to: 'treasuries#show'
    get '/treasury/advise', to: 'treasuries#advise'
    get '/treasury/transactions', to: 'treasuries#transactions', as: 'transactions'
  end

resources :comments, only: [:edit, :update, :destroy]


end
