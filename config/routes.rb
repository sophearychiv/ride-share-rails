Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homepages#index"
  get "hompages/passengers", to: "homepages#index", as: "all_passengers"
  resources :homepages
end
