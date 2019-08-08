Rails.application.routes.draw do
  root "home_page#index"

  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks" }

    devise_scope :user do
      get 'login', to: 'devise/sessions#new'
    end

    devise_scope :user do
      get 'signup', to: 'devise/registrations#new'
    end

    resources :recipes, :ingredients, :directions, :recipe_ingredients

    resources :users, only: [:show] do
      resources :recipes, only: [:show, :index]
    end

    # get 'recipes/recipe_long', to: 'recipes#recipe_long'
    # resources :recipes, only: [:show] do
    #   resources :ingredients, only: [:index, :new, :create]
    # end
end
