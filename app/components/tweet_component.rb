# frozen_string_literal: true

class TweetComponent < ViewComponent::Base
  attr_reader :tweet

  def initialize(tweet:)
    @tweet = tweet
  end

  def url
    show_profile_path(username: tweet.user.username)
  end
end
