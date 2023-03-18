class Tweet < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }
end
