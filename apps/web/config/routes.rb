root to: 'home#show'

resources :trips, only: [:show, :new, :create] do
  resources :housings, only: [:new, :create]
end

resource :styleguide, only: :show
