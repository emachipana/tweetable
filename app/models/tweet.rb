class Tweet < ApplicationRecord
  belongs_to :user
  has_many :replies, class_name: "Tweet",foreign_key: "parent_id", dependent: :destroy, inverse_of: "replied_to"
  belongs_to :replied_to. class_name: "Tweet",optional: true
  has_many :likes
  has_many :users, through: :likes
end
