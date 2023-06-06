# frozen_string_literal: true

class LikeComponent < ViewComponent::Base
  attr_reader :tweet

  def initialize(tweet:)
    @tweet = tweet
  end

  def current_user_like
    tweet.likes.find_by(user: Current.user)
  end

  def liked?
    current_user_like.present?
  end

  def likes_count
    tweet.likes_count
  end

  def form_action_url
    if liked?
      tweet_like_path(tweet, current_user_like)
    else
      tweet_likes_path(tweet)
    end
  end

  def form_method
    if liked?
      :delete
    else
      :post
    end
  end

  def button_title
    if liked?
      "Unlike"
    else
      "Like"
    end
  end
end
