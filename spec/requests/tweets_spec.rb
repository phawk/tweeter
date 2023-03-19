require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/tweets/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /tweets" do
    let(:user) { users(:pete) }

    before { sign_in(user) }

    it "creates a tweet" do
      post "/tweets", params: {
        tweet: {
          body: "Hello world"
        }
      }
      expect(response).to have_http_status(:success)
      expect(user.tweets.last.body).to eq("Hello world")
    end
  end

end
