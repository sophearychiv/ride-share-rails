Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  resources :trips, except: [:index]

  # resources :homepages
  resources :passengers do
    resources :trips
  end

  resources :drivers do
    resources :trips
  end

  patch "/drivers/:id/online", to: "drivers#toggle_online", as: "toggle_online"
end
