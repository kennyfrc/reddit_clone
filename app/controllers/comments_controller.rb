class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id]) # to establish topic/X in topic/X/post/X/comments
    @post = Post.find(params[:post_id]) #to establish post/X in topic/X/post/X/comments
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

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end