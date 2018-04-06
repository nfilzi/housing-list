require 'sidekiq/web'

mount Sidekiq::Web, at: '/sidekiq'

root to: 'static/home#show'

namespace :users do
  get    'sign_in',  to: 'users/session#new',     as: :user_sign_in
  post   'sign_in',  to: 'users/session#create'
  delete 'sign_out', to: 'users/session#destroy', as: :user_sign_out

  get  'sign_up', to: 'users/registration#new', as: :user_sign_up
  post 'sign_up', to: 'users/registration#create'
end

resource :profile, only: [:edit, :update]

# custom trip routes
get '/trips/:status',          to: 'trips#index', as: :trips_by_status, status: /(ongoing|completed)/
get '/trips/:id/token/:token', to: 'trips#show',  as: :trip_by_token

resources :trips, only: [:index, :show, :new, :create, :edit, :update] do
  member do
    patch :join
  end

  resources :housings, only: [:new, :create, :edit, :update] do
    member do
      delete :dismiss
    end
  end
end

resource :styleguide, only: :show

# Static pages
resource :about, only: :show, controller: 'static/about'
