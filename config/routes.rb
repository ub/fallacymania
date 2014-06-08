Fallacymania::Application.routes.draw do


  root :to => "home#index"

  resources :sprites, :only => [:index, :show] do
    get :random, on: :collection
  end

  get "countdown/:time" , to: 'countdown#show', as: :countdown
  get "main" , to: 'main_page#show'
 end