class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
	before_filter :api_session_token_authenticate!

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid
  rescue_from ActionController::RoutingError, :with => :route_not_found

  def routing_error    
    raise ActionController::RoutingError.new(params[:path])
  end

  private

  #utilities

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

  # errors

 	def not_authorized(message = "not authorized")
		respond("message",message, 401)
 	end

  def not_found(message = "resource not found")
    respond("message", message, 404)
  end

  def record_invalid(message = "invalid record") 
    respond("message", message, 422)
  end

  def route_not_found(message = "route not found")
    respond("message", "route #{request.method_symbol.to_s.upcase} #{message.to_s} not found",404)
  end

  #responses

	def respond(key, value, code)
		render :text => "{ \"#{key}\": \"#{value}\" }", :status => code, :content_type => Mime::JSON
	end

  #other

end
