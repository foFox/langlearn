Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :sessions 
      resources :conversations
    end
  end
end
