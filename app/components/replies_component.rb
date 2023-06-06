# frozen_string_literal: true

class RepliesComponent < ViewComponent::Base
  attr_reader :tweet

  def initialize(tweet:)
    @tweet = tweet
  end

  def replies_count
    tweet.replies_count
  end
end
