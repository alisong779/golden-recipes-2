Rails.application.routes.draw do
  root "home_page#index"
  resources :recipes
  resources :ingredients
  resources :directions


  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks" }

    devise_scope :user do
      get 'login', to: 'devise/sessions#new'
    end

    devise_scope :user do
      get 'signup', to: 'devise/registrations#new'
    end

end
