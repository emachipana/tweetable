class LikesController < ApplicationController
  # POST /likes
  def create
    @tweet = Tweet.find_by(id: params[:tweet_id])
    @like = @tweet.likes.new(user: current_user)

    unless @like.save
      like = Like.find_by(user: current_user, tweet: @tweet)
      like.destroy
    end
    redirect_back_or_to root_path
  end
end
