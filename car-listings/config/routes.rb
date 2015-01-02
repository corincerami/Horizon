Rails.application.routes.draw do

  root "homes#show"
  resources :manufacturers, only: [:index, :show, :new, :create] do
    resource :cars, only: [:new, :create]
  end

  resources :cars, only: [:index, :show]

end
