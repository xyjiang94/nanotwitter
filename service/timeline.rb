get '/user/:username' do
  @user_name = params[:username]
  user = User.find_by username: @user_name
  if user == nil
    "user dosen't exit!"
  else
    n = 100
    @user_tweets = Tweet.where(user_id: user[:id]).order(create_time: :desc).limit(n)
    erb :userTimeline
  end
end
