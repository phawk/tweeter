class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, presence: true
end
