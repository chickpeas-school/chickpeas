Rails.application.routes.draw do
  resources :announcements
  resources :saleable_days, path: 'days'

  resources :parents do
    resources :children
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root to: "home#show"
end
