Fallacymania2::Application.routes.draw do

  resources :games do
    resources :players
  end

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  resources :sprites, :only => [:index, :show] do
    get :random, on: :collection
  end

  get "countdown/:time" , to: 'countdown#show', as: :countdown
  get "main" , to: 'main_page#show'
 end