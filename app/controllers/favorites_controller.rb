class FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: post)

    if favorite.save
      flash[:notice] = "Successfully favorited!"
      redirect_to [post.topic, post]
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to [post.topic, post]
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = Favorite.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Successfully unfavorited"
      redirect_to [post.topic, post]
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect_to [post.topic, post]
    end
  end

end
