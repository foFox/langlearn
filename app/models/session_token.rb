class SessionToken < ActiveRecord::Base
	belongs_to :user
	
	TTL = 20.minutes

	def initialize()
		super()
		self.token_string = SecureRandom.urlsafe_base64(nil, false)
		self.last_seen = Time.now
		return self
	end

	def expired?
		ttl < 1
	end

	def valid?(param=nil)
		super(param) and !expired?
	end

	def ttl
		return TTL unless last_seen
		elapsed = DateTime.now - last_seen
    	remaining = (TTL - elapsed).floor
    	remaining > 0 ? remaining : 0
	end
end
