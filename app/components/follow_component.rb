# frozen_string_literal: true

class FollowComponent < ViewComponent::Base
  attr_reader :profile

  def initialize(profile:)
    @profile = profile
  end

  def following?
    @profile.followed_by?(follower: Current.user)
  end
end
