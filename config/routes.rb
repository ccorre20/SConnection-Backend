Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      get    "/users/",      to: "users#index"
      post   "/users/",      to: "users#create"
      
      get    "/services/",   to: "services#index"
      post   "/services/",   to: "services#create"
    end
  end
end
