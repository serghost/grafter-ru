Grafter::Application.routes.draw do
  root :to => "page#index"

  match "/search" => "page#search"

  resources :universities
end
