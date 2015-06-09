class User < ActiveRecord::Base
  has_many :tweets

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
end
