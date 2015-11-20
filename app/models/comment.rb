class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  default_scope { order('updated_at DESC') }

  validates :body, length: {minimum: 5}, presence: true
  validates :user, presence: true

  after_create :send_favorite_emails

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      if should_receive_email_for?(favorite)
        FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
      end
    end
  end

  def should_receive_email_for?(favorite)
    user_id != favorite.user_id && favorite.user.email_favorites? 
      # if the user_id is NOT equal to teh user_id that favorited the post AND
      # if teh user elects to receive emails on their favorite posts
  end
end
