class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
  	skip_before_action :verify_authenticity_token
	before_filter :api_session_token_authenticate!

 	private

  	def signed_in?
    	!!current_api_session_token.user
  	end

  	def current_user
    	current_api_session_token.user
  	end

  	def authenticate_with_password(user, attempt)
    	user && BCrypt::Password.new(user.password_hash) == attempt
  	end

  	def api_session_token_authenticate!
    	not_authorized unless !current_api_session_token.nil? and current_api_session_token.valid?
  	end

  	def current_api_session_token
  		token = SessionToken.find_by_token_string(request.headers['HTTP_AUTHORIZATION'])
  		token ||= SessionToken.find_by_token_string(cookies['session_token'])
    	@current_api_session_token ||= token
  	end

 	def not_authorized(message = "Not Authorized")
		respond("message","not authorized", 401)
 	end

	def respond(key, value, code)
		render :text => "{ \"#{key}\": \"#{value}\" }", :status => code, :content_type => Mime::JSON
	end

end
