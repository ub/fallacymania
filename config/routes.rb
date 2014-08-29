Fallacymania::Application.routes.draw do


  get 'stream/show'

  get 'marquee/show'

  get 'omniauth_callback/google_oauth2'

  devise_for :users,  controllers: { omniauth_callbacks: "omniauth_callbacks" }

  root :to => "home#index"

  resources :sprites, :only => [:index, :show] do
    get :random, on: :collection
  end

  resources :games do
    member do
      get :play
    end
    resource :stream, only: [:show, :destroy], controller: :stream do

    end
    resources :players
  end

  get "countdown/:time" , to: 'countdown#show', as: :countdown
  get "main" , to: 'main_page#show'

  get "marquee", to: 'marquee#show'

  # static / almost static pages

  get "about", to: 'home#about'

 end