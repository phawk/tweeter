# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def initials
    [
      user.first_name.split("").first,
      user.last_name.split("").first
    ].join("")
  end
end
