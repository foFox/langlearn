class User < ActiveRecord::Base
	has_one :session_token
	has_many :conversations

	validates_presence_of   :name,		   	on: :create
	validates_presence_of   :surname,   	on: :create
	validates_presence_of   :password_hash, on: :create
  	validates_presence_of   :email_address, on: :create
  	validates_presence_of 	:user_type 	  , on: :create
  	validates_uniqueness_of :email_address, on: :create  	

  	def password=(secret)
    	write_attribute(:password_hash, BCrypt::Password.create(secret))
  	end
end
