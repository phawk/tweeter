require 'rails_helper'

RSpec.describe "Follows", type: :request do
  let(:user) { users(:pete) }
  let(:other_user) { users(:lazaro_nixon) }

  before { sign_in(user) }

  describe "POST /profiles/:username/follows" do
    it "follows the profile" do
      expect do
        post profile_follows_path(profile_username: other_user.username)
        expect(response).to redirect_to(profile_path(username: other_user.username))
        follow = Follow.last
        expect(follow.following).to eq(other_user)
        expect(follow.follower).to eq(user)
      end.to change(Follow, :count).by(1)
    end

    it "does nothing if the profile is already followed" do
      Follow.create!(following: other_user, follower: user)

      expect do
        post profile_follows_path(profile_username: other_user.username)
        expect(response).to redirect_to(profile_path(username: other_user.username))
      end.not_to change(Follow, :count)
    end
  end

  describe "DELETE /profiles/:username/follows" do
    it "unfollows the profile" do
      Follow.create!(following: other_user, follower: user)

      expect do
        delete profile_follows_path(profile_username: other_user.username)
        expect(response).to redirect_to(profile_path(username: other_user.username))
      end.to change(Follow, :count).by(-1)
    end

    it "does nothing if the profile is not followed" do
      expect do
        delete profile_follows_path(profile_username: other_user.username)
        expect(response).to redirect_to(profile_path(username: other_user.username))
      end.not_to change(Follow, :count)
    end
  end
end
