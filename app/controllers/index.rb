get '/' do
  erb :index
end

get '/:username' do
  @user = User.find_by_username(params[:username])
  if @user.tweets.empty?
    @timeline = @user.fetch_tweets!
  else
    @timeline = @user.tweets
  end
  end
  erb :show
end