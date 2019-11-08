Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#home", as: "root"
  get "/users_connect", to: "users#index", as: "users"
  post "/users_connect", to: "users#create"
  get "/users_connect/new", to: "users#new", as: "new_user"
  get "/users_connect/new_student", to: "users#new_student", as: "students"
  post "/users_connect/new_student", to: "users#create_student"
  get "/users_connect/new_tutor", to: "users#new_tutor", as: "tutors"
  post "/users_connect/new_tutor", to: "users#create_tutor"
  get "/users_connect/:id", to: "users#show", as: "user_profile"
  get "/user_connect/:id/edit_student", to: "users#edit_student", as: "edit_student"
  patch "/user_connect/:id/edit_student", to: "users#update_student", as: "student"
  get "/user_connect/:id/edit_tutor", to: "users#edit_tutor", as: "edit_tutor"
  patch "/user_connect/:id/edit_tutor", to: "users#update_tutor", as: "tutor"
  

  get "/payments/success", to: "payments#success", as: "successful_payment"
  post "/payments/webhook", to: "payments#webhook", as: "verification"
end
