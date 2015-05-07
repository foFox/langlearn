FactoryGirl.define do
  
  factory :tutor, class: User do
    name "rob"
    surname  "fox"
    email_address "rob_fox@nd.edu"
    password "Password123@"
    user_type "tutor"
    after(:create) do |tutor|
      tutor.languages << Language.new(:name => "Polish")
      tutor.save
    end
  end

  factory :student, class: User do
    name "rob"
    surname  "pow"
    email_address "rob_pow@nd.edu"
    password "Password123@"
    user_type "student"
  end

  factory :other_user, class: User do
    name "rob"
    surname  "swi"
    email_address "rob_swi@nd.edu"
    password "Password123@"
    user_type "student"
  end

  factory :session_tutor, class: SessionToken do
    token_string "abcd1"
    association :user, :factory => :tutor
  end

  factory :session_student, class: SessionToken do
    token_string "abcd2"
    association :user, :factory => :student
  end

  factory :session, class: SessionToken do
    token_string "abcd3"
    association :user
  end

  factory :english_language, class: Language do
    name "English"
  end

  factory :conversation, class: Conversation do
    association :tutor, :factory => :tutor
    association :student, :factory => :student
    state "new"
    after(:build) do |conversation|
      conversation.language = conversation.tutor.languages[0]
    end
  end

end