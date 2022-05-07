module Api
  class LikesController < ApiController
    def create
      @tweet = Tweet.find(params[:tweet_id])
      @like = @tweet.likes.new(user: current_user)

      if @like.save
        render json: @like, status: :created
      else
        like = Like.find_by(user: current_user, tweet: @tweet)
        like.destroy
        render json: [], status: :no_content
      end
    end
  end
end