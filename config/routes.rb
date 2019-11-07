Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#home", as: "root"
  resources :conversations do
    resources :messages
  end
  get "/users_connect", to: "users#index", as: "users"
  post "/users_connect", to: "users#create"
  get "/users_connect/new", to: "users#new", as: "new_user"
  get "/users_connect/new_student", to: "users#new_student", as: "students"
  post "/users_connect/new_student", to: "users#create_student"
  get "/users_connect/new_tutor", to: "users#new_tutor", as: "tutors"
  post "/users_connect/new_tutor", to: "users#create_tutor"
  get "/users_connect/:id", to: "users#show", as: "user_profile"
  patch "/user_connect/:id", to: "users#update"
  get "/user_connect/:id/edit", to: "users#edit", as: "edit_user"
  delete "/users_connect/:id", to: "users#destroy"

  get "/payment/success", to: "payments#success", as: "successful_payment"
  post "/payment/webhook", to: "payments#webhook", as: "verification"

  resources :conversations do
    resources :messages
  end
end
