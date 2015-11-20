Rails.application.routes.draw do
  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      get     "/users/",            to: "users#index"
      post    "/users/",            to: "users#create"
      
      get     "/services/",         to: "services#index"
      post    "/services/",         to: "services#create"
      delete  "/services/",         to: "services#destroy"

      get     "/locations/",        to: "locations#index"
      post    "/locations/",        to: "locations#create"

      get     "/service_statuses/", to: "service_statuses#index"
      post    "/service_statuses/", to: "service_statuses#create"
    end
  end
end
