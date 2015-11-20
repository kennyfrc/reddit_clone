FactoryGirl.define do
  factory :comment do
    body "this is some commentt"
    user
    post

    after(:build) do |comment|
      comment.class.skip_callback(:create, :after, :send_favorite_emails) # skip the callback -> check the order of the arguments
    end
  end
end