class LikesController < ApplicationController
  # POST /likes
  def create
    @tweet = Tweet.find_by(id: params[:tweet_id])
    @like = @tweet.likes.new(user: current_user)

    if @like.save
      redirect_to tweets_path
    else
      like = Like.find_by(user: current_user, tweet: @tweet)
      like.destroy
      redirect_to tweets_path
    end
  end
end
