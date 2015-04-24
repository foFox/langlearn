Rails.application.routes.draw do	

  	namespace :api do
    	namespace :v1 do
      		resource :sessions 
      		resources :users
      		resources :languages do
            resources :users, :controller => 'languages/users'
          end
      		resources :conversations     
      		resource :me do      			
      			resources :languages, :controller => "me/languages"
      		end
    	end
  	end

  	match "*path", :to => "application#routing_error", via: :all
end
