class LikesController < ApplicationController
  before_action :set_tweet

  def create
    Like.where(user: Current.user, tweet: @tweet).first_or_create!

    render_like_component
  end

  def destroy
    existing_like = Like.find_by(user: Current.user, tweet: @tweet)
    existing_like&.destroy

    render_like_component
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def render_like_component
    render turbo_stream: turbo_stream.replace(
      "tweet-#{@tweet.id}-like-button",
      LikeComponent.new(tweet: @tweet).render_in(view_context)
    )
  end
end
