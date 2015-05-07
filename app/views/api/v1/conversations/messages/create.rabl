object @message => :message
attributes :id, :text, :created_at

child :user do
	attributes :id, :name, :surname, :email_address, :user_type
end
