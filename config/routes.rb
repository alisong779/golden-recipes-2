Rails.application.routes.draw do
  root "home_page#index"

  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks" }

    devise_scope :user do
      get 'login', to: 'devise/sessions#new'
    end

    devise_scope :user do
      get 'signup', to: 'devise/registrations#new'
    end

    resources :recipes, :ingredients, :directions, :comments

    resources :users, only: [:show] do
      resources :recipes, only: [:show, :index]
    end

    resources :recipes, only: [:show] do
      resources :comments, only: [:new, :create, :show, :edit, :update, :destroy]
    end
end
