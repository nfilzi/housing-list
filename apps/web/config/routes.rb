root to: 'home#show'

resources :trips, only: [:show, :new, :create]

resource :styleguide, only: :show
