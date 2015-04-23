Rails.application.routes.draw do	

  	namespace :api do
    	namespace :v1 do
      		resource :sessions 
      		resources :users
      		resources :langauges
      		resources :conversations     
      		resources :me 
    	end
  	end

  	match "*path", :to => "application#routing_error", via: :all
end
