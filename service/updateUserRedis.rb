def updateUserRedis
  username=session[:username]
  $redis.del(username) unless $redis[username].nil?
  $redis.expire(username,3600)
  n = 100
  join_follows_tweets = Followerfollowing.joins('JOIN tweets ON tweets.user_id = followerfollowings.followed_user_id').where(user_id: session[:user_id])
  all_tweets = join_follows_tweets.merge(Tweet.order(create_time: :desc)).limit(n).select('tweets.id,tweets.nickname,tweets.username,tweets.content,tweets.create_time')
  all_tweets.each{|x|
    $redis.rpush(username,x.to_json)
  }
end
