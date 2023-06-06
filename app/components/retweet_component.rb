# frozen_string_literal: true

class RetweetComponent < ViewComponent::Base
  attr_reader :tweet

  def initialize(tweet:)
    @tweet = tweet
  end

  def retweets_count
    tweet.retweets_count
  end

  def can_retweet?
    tweet.can_retweet?(user: Current.user)
  end
end
