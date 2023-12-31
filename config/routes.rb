Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  # .................User............................
  devise_scope :user do
	  post 'user_login' => 'users/sessions#user_login'
	end

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: { format: :json } do

    # .................Program............................
    post 'create_program_through_category' => 'programs#create_program_through_category'
    get 'search_program_name' => 'programs#search_program_name'
    get 'search_program_status' => 'programs#search_program_status'
    get 'delete_customer_purchase', to: 'programs#delete_customer_purchase'
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
