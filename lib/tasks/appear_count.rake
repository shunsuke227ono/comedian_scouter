require 'open-uri'
require "selenium/webdriver"
namespace :appear_count do
  desc 'collect master data for comedians'
  task :monthly, [:start_date] => :environment do |t, args|
    p args
    comedians = Comedian.all.index_by(&:name)
    count_monthly(comedians, args[:start_date].to_date)
  end

  def count_monthly(comedians, start_date)
    p end_date = start_date.end_of_month
    monthly_appears = {}
    failed_urls = []
    browser = Watir::Browser.new(:phantomjs)

    start_date.upto(end_date) do |date|
      urls(date).each do |url|
        begin
          p url
          browser.goto(url)
          sleep(0.5)
          doc = Nokogiri::HTML.parse(browser.html)
          doc.css("#programlist").css("td").each do |td|
            comedian_ids = []
            names(td).each do |name|
              if comedians[name].present?
                id = comedians[name].id
                comedian_ids << id
                if monthly_appears[id].present?
                  monthly_appears[id] += 1
                else
                  monthly_appears[id] = 1
                end
              else
              end
            end
          end
        rescue
          failed_urls << url
          p "failed for #{url}"
        ensure
          next
        end
      end
    end

    p "failed_urls: #{failed_urls}"

    new_monthly_appears = monthly_appears.map do |id, count|
      MonthlyAppear.new(
        count: count,
        comedian_id: id,
        start_date: start_date
      )
    end

    MonthlyAppear.import new_monthly_appears
  end

  task :execute => :environment do
    comedians = Comedian.all.index_by(&:name)
    (2009..2015).each do |year|
      p "#{year} 4,1"
      count_quoter(comedians, Date.new(year,4,1), Date.new(year,7,31))
      sleep(180)
      p "#{year} 7,1"
      count_quoter(comedians, Date.new(year,7,1), Date.new(year,9,30))
      sleep(180)
      p "#{year} 10,1"
      count_quoter(comedians, Date.new(year,10,1), Date.new(year,12,31))
      sleep(180)
      p "#{year+1} 1,1"
      count_quoter(comedians, Date.new(year+1,1,1), Date.new(year+1,3,31))
      sleep(180)
    end
  end

  def count_quoter(comedians, start_date, end_date)
    quoter_appears = {}
    failed_urls = []
    browser = Watir::Browser.new(:phantomjs)

    start_date.upto(end_date) do |date|
      urls(date).each do |url|
        begin
          p url
          browser.goto(url)
          sleep(0.5)
          doc = Nokogiri::HTML.parse(browser.html)
          doc.css("#programlist").css("td").each do |td|
            comedian_ids = []
            names(td).each do |name|
              if comedians[name].present?
                # comedians[name].appear
                id = comedians[name].id
                comedian_ids << id
                if quoter_appears[id].present?
                  quoter_appears[id] += 1
                else
                  quoter_appears[id] = 1
                end
              end
            end
            # 過去2年間
            if date >= Date.new(2014, 4, 1)
              comedian_ids.combination(2) { |c| CoAppear.count_pair(c[0], c[1]) }
            end
          end
        rescue
          failed_urls << url
          p "failed for #{url}"
        ensure
          next
        end
      end
    end

    p "failed_urls: #{failed_urls}"

    new_quoter_appears = quoter_appears.map do |id, count|
      QuoterAppear.new(
        count: count,
        comedian_id: id,
        start_date: start_date
      )
    end

    QuoterAppear.import new_quoter_appears
  end

  def urls(date)
    [4,6,8,10,12].map { |c| "http://kakaku.com/tv/channel=#{c}/date=#{date.strftime("%Y%m%d")}" }
  end

  def names(td)
    td.inner_text.split(/[,【】（）]/).each {|e| e.strip!}.reject { |e| e.empty?}.uniq
  end
end
