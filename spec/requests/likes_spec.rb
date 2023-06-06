require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { users(:pete) }
  let(:tweet) { tweets(:petes_tweet) }

  before { sign_in(user) }

  describe "POST /tweets/:tweet_id/likes" do
    it "likes the tweet" do
      expect do
        post "/tweets/#{tweet.id}/likes"
        expect(response).to have_http_status(:success)
      end.to change(Like, :count).by(1)

      like = Like.last
      expect(like.user).to eq(user)
      expect(like.tweet).to eq(tweet)
    end

    it "is idempotent" do
      Like.create!(user: user, tweet: tweet)

      expect do
        post "/tweets/#{tweet.id}/likes"
        expect(response).to have_http_status(:success)
      end.not_to change(Like, :count)
    end
  end

  describe "DELETE /tweets/:tweet_id/likes/:id" do
    it "unlikes the tweet" do
      like = Like.create!(user: user, tweet: tweet)

      expect do
        delete "/tweets/#{tweet.id}/likes/#{like.id}"
        expect(response).to have_http_status(:success)
      end.to change(Like, :count).by(-1)
    end

    it "is idempotent" do
      expect do
        delete "/tweets/#{tweet.id}/likes/1"
        expect(response).to have_http_status(:success)
      end.not_to change(Like, :count)
    end
  end
end
