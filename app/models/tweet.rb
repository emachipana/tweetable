class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies, class_name: "Tweet",foreign_key: "replied_to_id", dependent: :destroy, inverse_of: "replied_to"
  belongs_to :replied_to, class_name: "Tweet",optional: true, counter_cache: :replies_count
  has_many :likes
end
