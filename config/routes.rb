Grafter::Application.routes.draw do
  devise_for :users

  root :to => "page#index"

  match "/search" => "universities#index"

  get 'universities/autocomplete_university_short'

  resources :universities do
    get "/reviews" => "universities#reviews", :as => "reviews", :on => :member

    resources :prices do
      put '/revision/:version' => "prices#revision", :as => "revision"
      delete '/revision/:version' => "prices#revision_remove", :as => "revision_remove"
    end

    resources :reviews
  end

  resources :users
end
