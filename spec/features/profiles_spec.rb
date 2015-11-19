# describe the visiting profiles test
# include the test factories
# before running the test, set the instance variables to an authenticated user
# describe teh not signed in test
# it should show the profile
# by visitinng the user_path first
# by expecting teh current_path to be equal to the user_path 
# in the before do block, add set the @post and the @comment (but w/ create)
# in the desribe it block, expect a page to have user, post, and comment with specific content

require 'rails_helper'

describe 'visiting profiles' do
  
  include TestFactories

  before  do
    @user = authenticated_user
    @post = associated_post(user: @user) # you need to initialize it with a user else there's no association
    @comment = Comment.new(user: @user, post: @post, body: "some content filler here")
    allow(@comment).to receive(:send_favorite_emails)
    @comment.save!
  end

  describe 'not signed in' do
    it 'shows the profile' do
      visit user_path(@user)
      expect(current_path).to eq(user_path(@user))

      expect(page).to have_content(@user.name)
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@comment.body)
    end
  end

end