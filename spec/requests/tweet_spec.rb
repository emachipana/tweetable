require "rails_helper"

describe 'Tweets', type: :request do
  describe 'index path' do
    it 'index path respond with http success status code' do
      get '/api/tweets'
      expect(response.status).to eq(200)
    end

    it 'returns a json with all tweets' do
      user = User.create(
          username: "UserTest",
          name: "Test",
          password: "123456",
          email: "test@mail.com"  
        )
      Tweet.create(user: user, body: "Tweet test rspec")

      get '/api/tweets'
      tweets = JSON.parse(response.body)
      expect(tweets.size).to eq 1
    end
  end

  describe 'show path' do
    it 'return https status not found' do
      get '/api/tweets/:id', params: {id: 'xxx'}
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a json with a tweet' do
      user = User.create(
        username: "UserTest",
        name: "Test",
        password: "123456",
        email: "test@mail.com"  
        )
      tweet = Tweet.create(user: user, body: "Tweet test rspec")
      get "/api/tweets/#{tweet.id}"
      tweet_json = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(tweet.id).to eq tweet_json["id"]
      expect(tweet.body).to eq tweet_json["body"]
      expect(user.id).to eq tweet_json["user_id"]
    end
  end
end
