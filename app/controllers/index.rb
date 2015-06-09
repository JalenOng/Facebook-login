get '/' do
  erb :index
end

get '/:username' do
  @user = User.find_by_username(params[:username])
  if @user.tweets.empty? || @user.tweets_stale?
    @tweets = @user.fetch_tweets!
  else
    @tweets = @user.tweets
  end
  erb :show
end