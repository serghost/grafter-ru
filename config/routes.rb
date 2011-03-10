Grafter::Application.routes.draw do
  devise_for :users

  root :to => "page#index"

  match "/search" => "page#search"

  resources :universities do
    resources :prices
    resources :reviews
  end
end
