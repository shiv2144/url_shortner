Rails.application.routes.draw do

#Page to add a API client simulator
root 'static_pages#home'

#Make API code separate from entire web application for easy maintenance and future versioning as /v1,/v2..
  namespace :api, path: '/' do
    namespace :v1 do
      post   'signup'  => 'users#create'
      post   'login'   => 'sessions#create'
      delete 'logout'  => 'sessions#destroy'
      resources :short_urls
      resources :short_visits
      resources :users
    end
  end
end
