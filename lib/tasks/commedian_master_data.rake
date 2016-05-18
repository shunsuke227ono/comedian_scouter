require 'open-uri'
require "selenium/webdriver"

namespace :comedian_master do
  desc 'collect master data for comedians'
  task :yoshimoto => :environment do
    LIST_URL = 'http://search.yoshimoto.co.jp/gojuon.html'

    yoshimoto_comedians = []
    comedian_names = []

    existing_comedians = Company.yoshimoto.comedians.index_by(&:name)

    browser = Watir::Browser.new(:phantomjs)

    browser.goto(LIST_URL)
    skip_indexes = [37, 39, 47, 48, 49]
    (1...50).each do |idx|
      next if skip_indexes.include?(idx)
      id = "g#{idx}"
      browser.link(:id, id).click
      sleep(1)
      doc = Nokogiri::HTML.parse(browser.html)
      # TODO: Topに名前出てる人も含むように。
      doc.css('ul.lists.group').css('li').each do |li|
        name = li.inner_text
        comedian_names << name
        next if existing_comedians[name].present?

        comedian = Comedian.new(
          name: name,
          url: li.css('a').first['href']
        )
        yoshimoto_comedians << comedian
      end
    end

    Comedian.import yoshimoto_comedians

    comedians = Comedian.all.index_by(&:name)

    comedians_companies = []
    comedian_names.each do |name|
      comedians_companies << ComediansCompany.new(
        comedian_id: comedians[name].id,
        company_id: Company::YOSHIMOTO_ID
      )
    end

    ComediansCompany.import comedians_companies
  end
end
