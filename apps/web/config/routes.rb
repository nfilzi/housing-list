root to: 'home#show'

namespace :users do
  get    'sign_in',  to: 'users/session#new',     as: :user_sign_in
  post   'sign_in',  to: 'users/session#create'
  delete 'sign_out', to: 'users/session#destroy', as: :user_sign_out

  get  'sign_up', to: 'users/registration#new', as: :user_sign_up
  post 'sign_up', to: 'users/registration#create'
end

resource :profile, only: [:edit, :update]

get '/trips/:id/token/:token', to: 'trips#show', as: :trip_by_token

resources :trips, only: [:index, :show, :new, :create] do
  collection do
    get :ongoing
    get :completed
  end

  resources :housings, only: [:new, :create]
end

resource :styleguide, only: :show
