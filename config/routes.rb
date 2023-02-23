Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post "users/register", to: 'sessions#register'
        post "users/login", to: 'sessions#create'
        get "users/me", to: 'users#me'
      end
    end
  end
end
