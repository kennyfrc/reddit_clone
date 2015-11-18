require 'rails_helper'

include TestFactories
include Devise::TestHelpers

describe VotesController do
  
  describe '#up_vote' do
    it "adds an upvote to the post" do
      request.env["HTTP_REFERER"] = '/'
      @post = associated_post
      @user = authenticated_user
      sign_in @user

      expect{
        post(:up_vote, post_id: @post.id)
      }.to change{ @post.up_votes }.by 1
    end
  end

end