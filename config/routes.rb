Rails.application.routes.draw do
  resources :employees do
    member do
      get 'calculate_tax'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
