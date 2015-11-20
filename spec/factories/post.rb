FactoryGirl.define do
  factory :post do
    title "Post Title"
    body "Insert some body text ehre"
    user 
    topic { Topic.create(name: "some topic name")}
  end
end