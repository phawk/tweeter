class TweetsController < ApplicationController
  skip_before_action :authenticate, only: %i[index show]

  def index
    @tweets = Tweet.all.ordered
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
    params.require(:tweet).permit(:body)
  end
end
