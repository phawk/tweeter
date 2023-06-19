require "rails_helper"

RSpec.describe Follow, type: :model do
  it { is_expected.to belong_to :following }
  it { is_expected.to belong_to :follower }
end
