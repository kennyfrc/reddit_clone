class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic

  default_scope { order('rank DESC')} #we got this by doing generate migration AddRankToPosts

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    #below gets the age of a post by subtracting a std time from its created_at time
    #a standard time in thsi context is called an epoch
    #dividen the distance in seconds since the epoch by the num of seconds in a day. this gives us the age in days.
    age_in_days = (self.created_at - Time.new(1970,1,1)) / (60 * 60 * 24) #1 day in seconds 
    
    #add the points (sum of the votes) to the age. this means taht the passing of one day wil be equiv to one down vote
    new_rank = points + age_in_days

    update_attribute(:rank, new_rank)
  end

  def create_vote
    user.votes.create(value: 1, post: self)
  end
end
