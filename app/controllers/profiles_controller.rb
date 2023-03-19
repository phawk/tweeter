class ProfilesController < ApplicationController
  skip_before_action :authenticate, only: :show
  before_action :set_profile

  def show
    @tweets = @profile.tweets.ordered
  end

  def edit
    if @profile != Current.user
      return redirect_to root_path, alert: "You are not allowed."
    end
  end

  private

  def set_profile
    @profile = User.find_by!(username: params[:username])
  end
end
