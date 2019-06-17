Rails.application.routes.draw do
  resources :announcements
  resources :saleable_days, path: 'days', only: [:index, :show, :destroy]

  get "/days/new/sell",      to: "saleable_days#new", defaults: { type: :sell }
  post "/days/sell",         to: "saleable_days#create", defaults: { type: :sell }
  get "/days/:id/edit/sell", to: "saleable_days#edit", defaults: { type: :sell }, as: "sell_day_edit"
  put "/days/:id/sell",      to: "saleable_days#update", defaults: { type: :sell }, as: "sell_day"
  patch "/days/:id/sell",    to: "saleable_days#update", defaults: { type: :sell }
  delete "/days/:id/sell",   to: "saleable_days#destroy_seller"

  get "/days/new/buy",       to: "saleable_days#new", defaults: { type: :buy }
  post "/days/buy",          to: "saleable_days#create", defaults: { type: :buy }
  get "/days/:id/edit/buy",  to: "saleable_days#edit", defaults: { type: :buy }, as: "buy_day_edit"
  put "/days/:id/buy",       to: "saleable_days#update", defaults: { type: :buy }, as: "buy_day"
  patch "/days/:id/buy",     to: "saleable_days#update", defaults: { type: :buy }
  delete "/days/:id/buy",    to: "saleable_days#destroy_buyer"

  resources :children, only: [:index, :show]

  resources :parents do
    resources :children, only: [:new, :create, :destroy], controller: "parents/children"
    resources :email_configs, only: [:edit, :update], controller: "parents/email_configs"
  end

  resources :years do
    resources :children, only: [:new, :create, :destroy], controller: "years/children"
  end

  resources :mass_messages, only: [:new, :create, :show]

  resources :sessions, only: [:create]

  get '/login', to: "sessions#new"
  delete '/logout', to: "sessions#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root to: "home#show"
end
