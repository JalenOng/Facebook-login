class User < ActiveRecord::Base
  has_many :tweets
  validates :username, uniqueness: true
  def fetch_tweets!
    @user_timeline = $client.user_timeline(self.username)
    @user = User.find_by_username(self.username)
    @tweets = @user_timeline.take(10)
    @tweets.each do |tweet|
      Tweet.create(user_id: @user.id, body: tweet.text)
    end
  end

  def tweets_stale?
    @tweets = self.tweets
    Time.now - @tweets.first.created_at >= 15
  end

  # def self.tweet(tweet)
  #   $client.update(tweet)

  # end

  def self.tweet(username,tweet)

    user = User.find_by_username(username)

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = "7jT3P3YScr5vv9aMUDdsq8uM2"
      config.consumer_secret = "H2TKJUzhLyni774wA9rOuhJPLIvUq5aA4ZjHxh6Z4dfjUDmTIb"
      # config.access_token        = user.token
      # config.access_token_secret = user.secret

      # Jalen
      # config.access_token         = "3050321708-3wW0zOpfcEWSQavcV5wokyUCFHrODgHcZPwtCi8"
      # config.access_token_secret = "kqouhHOY3gZTL3VX4V2d9H6lSm5ONNbS0BkEmdIkT5osI"

      # Janet
      config.access_token = user["access_token"]
      config.access_token_secret = "FBpiGOxbWej63Lwavs9GIoh8I8MALjpR3trSQgNXwF0I9"



    end

    client.update(tweet)
  end

end



