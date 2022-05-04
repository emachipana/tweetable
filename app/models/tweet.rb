class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :replied_to
end
