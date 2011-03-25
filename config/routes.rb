Grafter::Application.routes.draw do
  devise_for :users

  root :to => "page#index"

  match "/search" => "universities#index"

  get 'universities/autocomplete_university_short'

  resources :universities do
    get "/reviews" => "universities#reviews", :as => :member

    resources :prices
    resources :reviews
  end

  resources :users
end
