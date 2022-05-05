class User < ApplicationRecord
  # has_and_belongs_to_many :likes, :join_table => 'likes', :class_name => 'Tweet'
  # has_many :tweets

  has_many :tweets, :through => :likes
  has_many :likes
  has_many :tweets


  enum :role, { admin:0 ,regular:1 }
end
