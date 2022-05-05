class Tweet < ApplicationRecord
  validates :body, presence: true, length: { maximum: 140 }
  validate :main_tweet_exists?

  belongs_to :user
  has_many :replies, class_name: "Tweet", foreign_key: "replied_to_id", dependent: :destroy,
                     inverse_of: "replied_to"
  belongs_to :replied_to, class_name: "Tweet", optional: true, counter_cache: :replies_count
  has_many :likes, dependent: :destroy

  private

  def main_tweet_exists?
    return unless replied_to_id && Tweet.find_by(id: replied_to_id).nil?

    errors.add(:replied_to_id, "Should be a valid tweet id")
  end
end
