class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :root_tweet, optional: true, class_name: "Tweet"
  belongs_to :parent_tweet, optional: true, class_name: "Tweet"
  has_many :all_replies, class_name: "Tweet", foreign_key: :root_tweet_id
  has_many :direct_replies, class_name: "Tweet", foreign_key: :parent_tweet_id
  has_many :likes, dependent: :destroy

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def likes_count
    likes.count
  end

  def replies_count
    all_replies.count
  end
end
