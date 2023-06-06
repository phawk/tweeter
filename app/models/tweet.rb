class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :root_tweet, optional: true, class_name: "Tweet"
  belongs_to :parent_tweet, optional: true, class_name: "Tweet"
  belongs_to :retweet, optional: true, class_name: "Tweet"
  has_many :all_replies, class_name: "Tweet", foreign_key: :root_tweet_id
  has_many :direct_replies, class_name: "Tweet", foreign_key: :parent_tweet_id
  has_many :retweets, class_name: "Tweet", foreign_key: :retweet_id
  has_many :likes, dependent: :destroy

  validates :body, presence: true

  scope :root_tweets, -> { where(root_tweet_id: nil) }
  scope :ordered, -> { order(created_at: :desc) }

  def can_retweet?(user:)
    !user.tweets.where(retweet_id: id).any?
  end

  def retweet?
    retweet_id.present?
  end

  def author
    if retweet?
      retweet.user
    else
      user
    end
  end

  def likes_count
    likes.count
  end

  def replies_count
    if root_tweet_id.nil?
      all_replies.count
    else
      direct_replies.count
    end
  end

  def retweets_count
    retweets.count
  end
end
