Apipie.configure do |config|
  config.app_name                = "Langlearn"
  config.api_base_url            = "/api/v1"
  config.doc_base_url            = "/documentation"
  config.app_info				 = "This is API documentation for the langlearn web service. All calls require that the client is logged in, and maintains a session - this is determined by examining the session token placed in a cookie or HTTP_AUTHORIZATION header. Go to Sessions resource documentation for more info. The only endpoint which does not require a session is POST /users - user registration endpoint. Have fun."
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
