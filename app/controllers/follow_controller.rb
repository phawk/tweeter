class FollowController < ApplicationController
  before_action :set_profile

  def create
    @profile.follow!(follower: Current.user)
    redirect_to profile_path(username: @profile.username), notice: "Followed @#{@profile.username}"
  end

  def destroy
    @profile.unfollow!(follower: Current.user)
    redirect_to profile_path(username: @profile.username), notice: "Unfollowed @#{@profile.username}"
  end

  private

  def set_profile
    @profile = User.find_by!(username: params[:profile_username])
  end
end
