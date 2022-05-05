class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :tweet }

  belongs_to :user
  belongs_to :tweet, counter_cache: true
end
