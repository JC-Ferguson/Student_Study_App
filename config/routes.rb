Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "/", to: "pages#home", as: "root"
  authenticated :user do
    root 'pages#home'
  end
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  post "/conversations", to: "conversations#create", as: "conversations"
  get "/conversations/:id", to: "conversations#show", as: "conversation"
  post "/users_connect/conversations", to: "conversations#create"
  get "/users_connect/conversations/:id", to: "conversations#show"

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
  get "/user_connect/:id/edit", to: "users#edit", as: "edit_users"
end
# Rails.application.routes.draw do

#   devise_for :users

#   authenticated :user do
#     root 'users#index'
#   end

#   unauthenticated :user do
#     devise_scope :user do
#       get "/" => "devise/sessions#new"
#     end
#   end

#   resources :conversations do
#     resources :messages
#   end
# end