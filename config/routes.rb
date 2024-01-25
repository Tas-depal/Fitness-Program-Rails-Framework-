Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  get 'home' => 'api/users#home'
  get '/auth/google_oauth2/callback', to: 'api/omniauth#google_oauth2'
  namespace :api, defaults: { format: :json } do

    # .................User............................
    post 'user_login' => 'users#user_login'
    get 'verify_otp' => 'users#verify_otp'
    resource :users

    # .................Program............................
    post 'create_program_through_category' => 'programs#create_program_through_category'
    get 'search_program_name' => 'programs#search_program_name'
    get 'search_program_status' => 'programs#search_program_status'
    get 'show_active_program' => 'programs#show_active_program'
    get 'show_category_wise_programs' => 'programs#show_category_wise_programs'
    get 'search_by_category_and_name' => 'programs#search_by_category_and_name'
    get 'search_in_customer_program' => 'programs#search_in_customer_program'
    resources :programs

    # .................Purchases............................
    resources :purchases

    # .................Category.............................
    resources :categories

    # .................Order.............................
    resources :orders

    # .................Payment.............................
    resources :payments
  end

end
