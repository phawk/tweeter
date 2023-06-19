require "rails_helper"

RSpec.describe Tweet, type: :model do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :likes }

  describe "#can_retweet?(user:)" do
    let(:tweet) { tweets(:petes_tweet) }
    let(:user) { users(:lazaro_nixon) }

    it "returns true when user has not retweeted before" do
      expect(tweet.can_retweet?(user: user)).to be(true)
    end

    it "returns false when user has already retweeted" do
      user.tweets.create!(retweet_id: tweet.id, body: tweet.body)
      expect(tweet.can_retweet?(user: user)).to be(false)
    end

    it "returns false when user is nil" do
      expect(tweet.can_retweet?(user: nil)).to be(false)
    end
  end
end
