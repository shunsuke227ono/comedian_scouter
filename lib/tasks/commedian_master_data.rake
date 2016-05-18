require 'open-uri'

namespace :comedian_master do
  desc 'collect master data for comedians'
  task :yoshimoto => :environment do
    YOSHIMOTO_WIKI = 'https://ja.wikipedia.org/wiki/%E5%90%89%E6%9C%AC%E8%88%88%E6%A5%AD%E6%89%80%E5%B1%9E%E3%82%BF%E3%83%AC%E3%83%B3%E3%83%88%E4%B8%80%E8%A6%A7'

    charset = nil
    html = open(YOSHIMOTO_WIKI) do |f|
      charset = f.charset
      f.read
    end

    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(html, nil, charset)

    taget = doc.css("#mw-content-text ul li")

    yoshimoto_commedian_names = []
    first_comedian_name = 'R藤本'
    last_comedian_name = 'ビューティーメーカー'
    is_comedian = false

    doc.css('#mw-content-text').children().css('ul').each do |ul|
      ul.css('li').each do |li|
        name = li.css('a').inner_text
        is_comedian = true if name == first_comedian_name
        yoshimoto_commedian_names << name if is_comedian
        is_comedian = false if name == last_comedian_name
      end
    end

    puts yoshimoto_commedian_names
  end
end
