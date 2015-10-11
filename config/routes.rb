Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      get     "/users/",      to: "users#index"
      post    "/users/",      to: "users#create"
      
      get     "/services/",   to: "services#index"
      post    "/services/",   to: "services#create"

      get     "/locations/",  to: "locations#index"
      post    "/locations/",  to: "locations#create"
    end
  end
end
