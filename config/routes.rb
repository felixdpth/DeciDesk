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
    get '/treasury/advice', to: 'treasuries#advice'
    get '/treasury/transactions', to: 'treasuries#transactions'
    get '/treasury/comments', to: 'treasuries#comments'
    get '/sales', to: 'sales#show'
    get '/sales/advice', to: 'sales#advice'
    get '/sales/transactions', to: 'sales#transactions'
    get '/sales/comments', to: 'sales#comments'
  end

resources :comments, only: [:edit, :update, :destroy]


end
