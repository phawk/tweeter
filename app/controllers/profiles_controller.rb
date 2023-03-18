class ProfilesController < ApplicationController
  def show
    @profile = User.find_by!(username: params[:username])
    @tweets = @profile.tweets.ordered
  end

  def edit
  end
end
