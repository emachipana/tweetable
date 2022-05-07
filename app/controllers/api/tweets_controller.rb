module Api
  class TweetsController < ApiController
    before_action :set_tweet, only: %i[show edit update destroy]
    
    def index
      render json: Tweet.all.sort, status: :ok
    end

    def show
      render json: @tweet, status: :ok
    end

    def create
      @tweet = current_user.tweets.new(tweet_params)

      if @tweet.save
        render json: @tweet, status: :created
      else
        render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @tweet.update(tweet_params)
        render json: @tweet, status: :accepted
      else
        render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @tweet.destroy
      render json: [], status: :no_content
    end

    private

    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:body, :replied_to_id)
    end
  end
end