Grafter::Application.routes.draw do
  devise_for :users

  root :to => "page#index"

  match "/search" => "universities#index"

  resources :universities do
    resources :prices
    resources :reviews

    get "/reviews" => "universities#reviews", :as => :member
  end
end
