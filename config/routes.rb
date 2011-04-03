Grafter::Application.routes.draw do
  get "lessons/index"

  get "lessons/show"

  devise_for :users

  root :to => "page#index"

  match "/search" => "universities#index", :as => :search

  resources :universities do
    get :reviews, :as => "reviews", :on => :member

    resources :prices do
      post :delete_revisions, :on => :member, :as => :delete_revisions
      put '/revision/:version' => "prices#revision", :as => :revision
      delete '/revision/:version' => "prices#revision_remove", :as => :revision_remove
    end

    resources :reviews
    resources :lessons
  end

  resources :users do
    get 'profile' => "users#show", :as => :profile, :on => :collection
    get :reset, :on => :member
    get :give, :on => :member
  end
end
