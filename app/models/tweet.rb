class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def likes_count
    likes.count
  end
end
