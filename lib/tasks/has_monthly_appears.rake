namespace :has_monthly_appears do
  task :execute => :environment do |t, args|
    @comedians = Comedian.all.find_each do |c|
      c.update(has_monthly_appears: c.monthly_appears.count)
    end
  end
end
