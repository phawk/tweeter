class LikesController < ApplicationController
  before_action :set_tweet

  def create
    Like.where(user: Current.user, tweet: @tweet).first_or_create!
  end

  def destroy
    existing_like = Like.find_by(user: Current.user, tweet: @tweet)
    existing_like&.destroy
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
