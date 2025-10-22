Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "/api/contents", to: "contents#index"
  post "/api/contents", to: "contents#create"
  put "/api/contents/:id", to: "contents#update"
  delete "/api/contents/:id", to: "contents#destroy"
end
