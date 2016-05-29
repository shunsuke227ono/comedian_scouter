namespace :growths do
  task :create => :environment do
    (2011..2015).each do |year|
      growths = []
      Comedian.all.find_each do |c|
        last_year_count = c.monthly_appears.where("start_date >= '#{year-1}/04/01' AND start_date < '#{year}/04/01'").sum(:count)
        this_year_count = c.monthly_appears.where("start_date >= '#{year}/04/01' AND start_date < '#{year+1}/04/01'").sum(:count)
        if last_year_count != 0
          rate = this_year_count * 1.0 / last_year_count
        else
          rate = nil
        end
        growths << Growth.new(
          year: "#{year}/04/01",
          comedian_id: c.id,
          rate: rate,
          last_year_count: last_year_count,
          this_year_count: this_year_count
        )
      end
      Growth.import growths
    end
  end
end
