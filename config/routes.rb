Grafter::Application.routes.draw do
  devise_for :users

  root :to => "page#index"

  match "/search" => "universities#index"

  resources :universities do
    get "/reviews" => "universities#reviews", :as => "reviews", :on => :member

    resources :prices do
      post '/delete_revisions' => "prices#delete_revisions", :on => :member, :as => "delete_revisions"
      put '/revision/:version' => "prices#revision", :as => "revision"
      delete '/revision/:version' => "prices#revision_remove", :as => "revision_remove"
    end

    resources :reviews
  end

  resources :users do
    get '/profile' => "users#show", :as => "profile", :on => :collection
    get '/reset' => "users#reset", :on => :member
    get '/give' => "users#give", :on => :member
  end
end
