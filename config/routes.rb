Rails.application.routes.draw do
  devise_for :parents, controllers: { omniauth_callbacks: 'parents/omniauth_callbacks' }

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
  
  # allow users to change their password
  # see https://github.com/heartcombo/devise/wiki/How-To%3A-Allow-users-to-edit-their-password
  as :parent do
    get 'parents/edit',        to: 'devise/registrations#edit', :as => 'edit_parent_registration'    
    put 'parents',             to: 'devise/registrations#update', :as => 'parent_registration'            
  end
  
  resources :children, only: [:index, :show] do
    resources :parents, only: [:new, :create, :destroy], controller: "children/parents"
  end

  resources :parents do
    resources :children, only: [:new, :create, :destroy], controller: "parents/children"
    resources :email_configs, only: [:edit, :update], controller: "parents/email_configs"
    # in case we want to add external google users for oauth later
    # get "/parents/:id/link", to: "parents#link"
  end

  resources :years do
    post "/children/returning", to: "years/children#create", defaults: { type: :returning }
    post "/children/new", to: "years/children#create", defaults: { type: :new }

    resources :children, only: [:new, :update, :destroy], controller: "years/children"
  end

  resources :mass_messages, only: [:new, :create, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root to: "home#show"
end
