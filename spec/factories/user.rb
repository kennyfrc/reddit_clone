# generates an email for each user and mark them as confirmed_at
FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    sequence(:email, 100) { |n| "person#{n}@example.com"} # what does n mean here
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end