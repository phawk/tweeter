class TweetsController < ApplicationController
  skip_before_action :authenticate, only: %i[index show]
  before_action :set_tweet, only: :show

  def index
    @tweets = Tweet.root_tweets.ordered
  end

  def show
  end

  def new
  end

  def create
    tweet = Current.user.tweets.new(tweet_params)

    if tweet.save
      render(turbo_stream: [
        turbo_stream.prepend(
          "tweets",
          partial: "tweets/tweet",
          locals: {
            tweet: tweet,
            new_content: true
          }
        ),
        turbo_stream.replace(
          "tweet_form",
          partial: "tweets/form"
        )
      ])
    else
      redirect_to root_path, alert: "Tweet failed, try again."
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :root_tweet_id, :parent_tweet_id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
