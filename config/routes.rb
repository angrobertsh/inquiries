Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "units#index"

  resources :units, only: [:show, :index] do
    resources :inquiries, only: [:edit, :create, :update, :destroy]
  end

end
