collection @conversations, :root => 'conversations', :object_root => ''
attributes :id, :state

child :student => :student do
	attributes :id, :name, :surname, :email_address
end

child :tutor => :tutor do
	attributes :id, :name, :surname, :email_address
end

child :language do
	attributes :id, :name
end