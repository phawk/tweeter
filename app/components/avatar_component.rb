# frozen_string_literal: true

class AvatarComponent < ViewComponent::Base
  attr_reader :user, :size

  def initialize(user:, size: "h-12 w-12")
    @user = user
    @size = size
  end

  def avatar?
    user.avatar.attached?
  end

  def avatar_url
    url_for(user.avatar)
  end

  def initials
    [
      user.first_name.split("").first,
      user.last_name.split("").first
    ].join("")
  end
end
