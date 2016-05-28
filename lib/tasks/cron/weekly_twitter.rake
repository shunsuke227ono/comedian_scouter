namespace :weekly_tweets do
  task :count => :environment do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = Settings.twitter.consumer_key
      config.consumer_secret = Settings.twitter.consumer_secret
      config.access_token = Settings.twitter.access_token
      config.access_token_secret = Settings.twitter.access_token_secret
    end

    p Twitter::REST::Request.new(client, :get, 'https://api.twitter.com/1.1/application/rate_limit_status.json', resources: "search").perform
    p res = client.search("アインシュタイン")
    binding.pry

    # Comedian.all[4..430].each_with_index do |c,i|
    #   sleep(5)
    #   next if c.name.size < 3
    #   p c.name + " #{i}"
    #   WeeklyTweet.create(
    #     comedian_id: c.id,
    #     count: client.search(c.name).count,
    #     start_date: Date.today - 7
    #   )
    # end
  end
end
