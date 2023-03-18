# frozen_string_literal: true

class TweetComponent < ViewComponent::Base
  attr_reader :tweet

  def initialize(tweet:)
    @tweet = tweet
  end
end
