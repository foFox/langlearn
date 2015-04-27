Rails.application.routes.draw do	

  apipie
  	namespace :api do
    	namespace :v1 do
      		resource :sessions, only: [:create, :destroy]
      		resources :users, only: [:create]
      		resources :languages, only: [:index, :update] do
            resources :users, :controller => 'languages/users', only: [:index]
          end
      		resources :conversations, only: [] do
            resources :messages, :controller => 'conversations/messages',only: [:index, :create]
          end             
          resources :me, :controller => "me", only: [:index]
      		resource :me, only: [] do      			
      			resources :languages, :controller => "me/languages", only: [:index, :create, :destroy]
            resources :conversations, :controller => "me/conversations", only: [:index, :create]
      		end
    	end
  	end

  	match "*path", :to => "application#routing_error", via: :all
end
