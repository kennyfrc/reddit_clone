require 'rails_helper'


describe Comment do

  include TestFactories

  before do
    @user = authenticated_user(email_favorites: true)
    @post = associated_post
    @other_user = authenticated_user
    @comment = Comment.new(body: 'My comment is really great', post: @post, user: @other_user)
  end

  describe "favorited(post)" do
    it "sends an email if the user favorites a post" do
      favorite = @user.favorites.create(post: @post)

      allow (FavoriteMailer) #mailers allow you to send emails from your application 
                             #usign mailer classes and views. they work similarly to
                             #controllers. they inherit from ActionMailer::Base and
                             #are placed in app/mailers and they have assoc app/viewsc
        .to receive(:new_comment)
        .with(@user, @post, @comment)
        .and_return( double(deliver_now: true))

      expect(FavoriteMailer)
        .to receive(:new_comment)

      @comment.save
    end

    it "does not send an email if the user doesn't favorite a post" do  
      expect( FavoriteMailer )
        .not_to receive(:new_comment)

      @comment.save
    end

  end
  
end