require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  let(:user) { users(:pete) }
  describe "GET /:username" do
    context "when signed out" do
      it "returns http success" do
        get "/#{user.username}"
        expect(response).to have_http_status(:success)
      end
    end

    context "when signed in" do
      it "returns http success" do
        sign_in(user)
        get "/#{user.username}"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/profiles/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
