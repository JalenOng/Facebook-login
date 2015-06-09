get '/' do
  erb :index
end

post '/show' do
  @user = User.find_or_create_by(username: params[:username])
  if @user.tweets.empty? || @user.tweets_stale?
    @tweets = @user.fetch_tweets!
  else
    @tweets = @user.tweets
  end
  return @tweets.to_json
end