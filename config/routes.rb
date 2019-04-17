Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  resources :trips

  # resources :homepages
  resources :passengers do
    resources :trips
  end

  resources :drivers do
    resources :trips
  end
end
