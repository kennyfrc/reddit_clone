require 'rails_helper'

describe FavoritesController do
  
  include TestFactories
  include Devise::TestHelpers

  before do
    @post = associated_post
    @user = authorized_user
    sign_in @user
  end

  describe '#create' do
    it "creates a favorite for the current user and specified post" do
      expect( @user.favorites.find_by_post_id(@post.id)).to be_nil

      post :create, {post_id: @post_id} # post as in the HTTP request. not the model.

      expect( @user.favorites.find_by_post_id(@post.id)).not_to be_nil #finds a single favorite
                                                                       #or return nil
    end
  end

  describe '#destroy' do
    it "destroys the favorite for the current user and specified post" do
      favorite = @user.favorites.where(post: @post).create
      expect( @user.favorites.find_by_post_id(@post.id) ).not_to be_nil

      delete :destroy, { post_id: @post.id, id: favorite.id } #delete is the HTTP request

      expect( @user.favorites.find_by_post_id(@post.id)).to be_nil
    end
  end

end