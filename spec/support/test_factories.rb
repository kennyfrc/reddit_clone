module TestFactories
  def associated_post(options = {}) # recreate the method in that it accepts multiple options WITH defaults
    post_options = {
      title: "some post title", 
      body: "some post body that has to be long", 
      topic: Topic.create(name: "some topic name"), 
      user: authenticated_user
    }.merge(options) #merge = merges in the conditions WITH other, if the other is an ActiveRecord::Relation
    Post.create(post_options)
  end

  def authenticated_user(options = {})
    user_options = {
      email: "email#{rand}@fake.com", 
      password: "password"
    }.merge(options)
    user = User.new(user_options)
    user.skip_confirmation! #it's a devise method that circumvents :confirmable
    user.save #this is an activerecord method which throws either true or false
    user
  end

end