require 'open-uri'
require "selenium/webdriver"

namespace :co_appear_counter do
  desc 'collect master data for comedians'
  task :tv_asahi => :environment do
    comedians = Comedian.all.index_by(&:name)

    Date.new(2016,3,1).upto(Date.new(2016,3,31)) do |date|
      sleep(0.5)

      url = "http://kakaku.com/tv/channel=10/date=#{date.strftime("%Y%m%d")}"
      p url

      browser = Watir::Browser.new(:phantomjs)
      browser.goto(url)
      doc = Nokogiri::HTML.parse(browser.html)

      doc.css("#programlist").css("td").each do |td|
        comedian_ids = []
        names(td).each do |name|
          comedian_ids << comedians[name].id if comedians[name].present?
        end
        comedian_ids.combination(2) { |c| CoAppear.count_pair(c[0], c[1]) }
      end
    end
  end

  def names(td)
    td.inner_text.split(/[,【】（）]/).each {|e| e.strip!}.reject { |e| e.empty?}.uniq
  end
end
