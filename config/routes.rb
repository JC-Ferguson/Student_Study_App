Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#home", as: "root"
  get "/users_connect", to: "users#index", as: "users"
  post "/users_connect", to: "users#create"
  get "/users_connect/new", to: "users#new", as: "new_user"
  get "/users_connect/:id", to: "users#show", as: "user_profile"
  patch "/user_connect/:id", to: "users#update"
  get "/user_connect/:id/edit", to: "users#edit", as: "edit_users"
end
