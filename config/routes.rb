Rails.application.routes.draw do
  resources :announcements
  resources :saleable_days, path: 'days'

  resources :children, only: [:index, :show]

  resources :parents do
    resources :children, only: [:new, :create, :destroy], controller: "parents/children"
  end

  resources :years do
    resources :children, only: [:new, :create, :destroy], controller: "years/children"
  end

  resources :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root to: "home#show"
end
