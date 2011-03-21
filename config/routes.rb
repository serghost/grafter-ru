Grafter::Application.routes.draw do
  devise_for :users

  root :to => "page#index"

  match "/search" => "universities#index"

  resources :universities do
    get "/reviews" => "universities#reviews", :as => :member

    resources :prices
    resources :reviews
  end

  resources :users
end
