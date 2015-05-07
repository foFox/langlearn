VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
VALID_USER_TYPE_REGEX = /student|tutor/

class User < ActiveRecord::Base
	has_many :session_tokens
	has_many :conversations  
  has_and_belongs_to_many :languages

	validates :name, :on => :create, :presence => true, :length => { :minimum => 2, :maximum => 255 } 
	validates :surname, :on => :create, :presence => true, :length => { :minimum => 2, :maximum => 255 }
  validates :email_address, :on => :create, :format => { :with => VALID_EMAIL_REGEX, :message => "invalid email_address format" }, :presence => true, :uniqueness => true, :length => { :maximum => 255 }
  validates :user_type, :on => :create, :format => {:with => VALID_USER_TYPE_REGEX , :message => "user type can be user or tutor" }, :presence => true 
  validates_presence_of  :password_hash, on: :create

  	def password=(secret)
    	write_attribute(:password_hash, BCrypt::Password.create(secret))
  	end

    def conversations
        if user_type == 'student' then
          Conversation.find_by_student_id(id)
        else
          Conversation.find_by_tutor_id(id)
        end
    end    
end
