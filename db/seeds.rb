require "faker"

puts "Destroying all data"
Tweet.destroy_all
User.destroy_all
Like.destroy_all

puts "Create an admin"
admin = User.new(
    email: "admin@mail.com",
    username: "admin",
    name: "Paulo",
    password: "supersecret",
    role: "admin"
)

if admin.save
  puts "Create admin succesfully"
else
  puts admin.errors.full_messages
end

4.times do |n|
  user = User.new(
      email: "test#{n}@mail.com",
      username: Faker::Internet.username,
      name: Faker::Name.first_name,
      password: "123456"
  )

  if user.save
    puts "User #{n} created succesfully"
    2.times do
      tweet = user.tweets.new(body: Faker::Quote.famous_last_words )

      if tweet.save
        puts "tweet created succesfully"
        like = tweet.likes.create(user: user)
      else
        puts tweet.errors.full_messages
      end
    end
  else
    puts user.errors.full_messages  
  end
end

2.times do
  retweet = Tweet.new(
      body: Faker::Quote.famous_last_words,
      replied_to_id: Tweet.all.sample.id,
      user_id: User.where(role: 0).sample.id
    )
  if retweet.save
    puts "Retweet created succesfully"
  else
    puts retweet.errors.full_messages
  end
end
