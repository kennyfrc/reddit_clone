class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id]) # to establish topic/X in topic/X/post/X/comments
    @post = @topic.posts.find(params[:post_id]) #to establish post/X in topic/X/post/X/comments
    @comment = @post.comments.new(comment_params) #to create a new comment (which is currently just part of post)
    @comment.user = current_user 
    @comment.post = @post #there's no topic because comment technically is not part of topic
    if @comment.save
      flash[:notice] = "Comment was saved"
      redirect_to [@topic, @post] #just topic/X/post/X
    else
      flash[:error] = "Something went wrong. Please try again"
      redirect_to [@topic, @post] #just topic/X/post/X
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       redirect_to [@topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       redirect_to [@topic, @post]
     end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end