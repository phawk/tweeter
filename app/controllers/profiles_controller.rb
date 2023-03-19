class ProfilesController < ApplicationController
  skip_before_action :authenticate, only: :show

  def show
    @profile = User.find_by!(username: params[:username])
    @tweets = @profile.tweets.ordered
  end

  def edit
  end
end
