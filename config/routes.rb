Rails.application.routes.draw do
  root "main#index"

  # devise_for :users

  devise_for :users, skip: [:sessions, :registrations, :passwords]

  as :user do
    # sessions
    get    'login',  to: 'devise/sessions#new',           as: :new_user_session
    post   'login',  to: 'devise/sessions#create',        as: :user_session
    delete 'logout', to: 'devise/sessions#destroy',       as: :destroy_user_session

    # registrations
    get 'cancel', to: 'devise/registrations#cancel',      as: :cancel_user_registration
    get 'sign_up', to: 'devise/registrations#new',        as: :new_user_registration
    get 'edit', to: 'devise/registrations#edit',          as: :edit_user_registration
    patch 'users', to: 'devise/registrations#update',     as: :user_registration
    put 'users', to: 'devise/registrations#update'
    delete 'users', to: 'devise/registrations#destroy'
    post 'users', to: 'devise/registrations#create'

    # passwords
    get   'password/new',  to: 'devise/passwords#new',    as: :new_user_password
    get   'password/edit', to: 'devise/passwords#edit',   as: :edit_user_password
    patch 'password', to: 'devise/passwords#update',      as: :user_password
    post  'password',  to: 'devise/passwords#create'
    put   'password', to: 'devise/passwords#update'

    # user disc details
    get "/user_details", to: "disc_details#general_details", as: :details_of_user
    post "/user_details" => "disc_details#general_details"

    # error for edisk_directory
    get "/error", to: "edisk_directories#wrong_id", as: :wrong_id
  end


  # get "edisk_directory/:id/new", to: "edisk_directory#new"

  # get "edisk_directory/:id/edit", to: "edisk_directory#edit"
  # post "edisk_directory/:id/edit", to: "edisk_directory#update"

  # delete "edisk_directories/:id/destroy", to:"edisk_directory#destroy"
  resources :edisk_directories
  post "/edisk_directories/new(.:format)", to: "edisk_directories#create"
  # post "/edisk_directory/new", to: "edisk_directory#create"
  # post "/edisk_directory/:id", to: "edisk_directory#create"

  # post "/edisk_directory/:id/edit", to:"edisk_directory#update"
  post "/edisk_files/new(.:format)", to: "edisk_files#create"
  resources :edisk_files
  # post "/edisk_file/:id/edit", to:"edisk_file#update"

  # admin
  as :admin do
    get '/ed-admin' => 'admin#dashboard', as: :admin_dashboard
    delete "/ed-admin/:id" => 'admin#destroy', as: :admin_dashboard2
  end
  # match '*path' => 'edisk_directories#wrong_id', via: :all

end


