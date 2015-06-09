class User < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    @user_timeline = $client.user_timeline(self.username)
    @user = User.find_by_username(self.username)
    @user_timeline.each do |tweet|
      Tweet.create(user_id: @user.id, body: tweet.text)
    end
    @user_timeline
  end
end
