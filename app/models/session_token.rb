class SessionToken < ActiveRecord::Base
	belongs_to :user
	
	TTL = 20.minutes

	def initialize()
		super()
		self.token_string = SecureRandom.urlsafe_base64(nil, false)		
		return self
	end

	def expired?
		ttl < 1
	end

	def valid?(param=nil)
		super(param) and !expired?
	end

	def ttl
		return TTL unless created_at
		elapsed = (Time.zone.now - created_at) / 60
    	remaining = ((TTL.to_i / 60) - elapsed).floor    	
    	remaining > 0 ? remaining : 0
	end
end
