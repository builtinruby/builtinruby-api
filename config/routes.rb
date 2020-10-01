Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root to: 'home#index'

      resource :jobs, only: :create
      resource :companies, only: :create
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
