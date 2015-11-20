class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def admin?
   role == 'admin'
  end
 
  def moderator?
    role == 'moderator'
  end

  def favorited(post)
    favorites.where(post_id: post.id).first
  end

  def voted(post)
    votes.where(post_id: post.id).first #returns a vote if it exists.. 
                                        #first is just a way for us to call it
  end

  def self.top_rated #why a class method? 
    self.select('users.*') # selects all attributes of the user
        .select('COUNT(DISTINCT comments.id) AS comments_count') #count the comments made by the user
        .select('COUNT(DISTINCT posts.id) AS posts_count') # count the posts made by the user
        .select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank') #add the comemnt count to the post count and label the sum as rank
        .joins(:posts) # ties teh post table to the users table, via the user_id
        .joins(:comments) # ties the comments table to the users table, via the user_id
        .group('users.id') #instructs the database to group the results by user (in a distinct row)
        .order('rank DESC') #instructs the databse to order the rank in descending order (rank = comment.count + post.count)
  end
end
