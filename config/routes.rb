Fallacymania2::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  resources :sprites, :only => [:index, :show] do
    get :random, on: :collection
  end
end