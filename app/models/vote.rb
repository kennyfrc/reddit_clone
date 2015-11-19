class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote."}

  after_save :update_post


  def up_vote? # checks whether it is true that the value is 1
    value == 1
  end

  def down_vote?
    value == -1
  end

  private

  def update_post
    post.update_rank
  end
end
