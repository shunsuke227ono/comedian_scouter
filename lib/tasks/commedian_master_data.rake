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
      sleep(3)
      doc = Nokogiri::HTML.parse(browser.html)
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

    yoshimoto_comedians << Comedian.new(
      name: "明石家さんま",
      url: "http://search.yoshimoto.co.jp/talent_prf/?id=873"
    )
    yoshimoto_comedians << Comedian.new(
      name: "西川きよし",
      url: "http://search.yoshimoto.co.jp/talent_prf/?id=702"
    )
    comedian_names << "明石家さんま"
    comedian_names << "西川きよし"

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

  task :horipro => :environment do
    comedians = []

    comedians << Comedian.new(
      name: "イジリー岡田",
      url: "http://www.horipro.co.jp/ijiriokada/"
    )
    comedians << Comedian.new(
      name: "さまぁ～ず",
      url: "http://www.horipro.co.jp/summers/"
    )
    comedians << Comedian.new(
      name: "大竹一樹",
      url: "http://www.horipro.co.jp/summers/"
    )
    comedians << Comedian.new(
      name: "三村マサカズ",
      url: "http://www.horipro.co.jp/summers/"
    )
    comedians << Comedian.new(
      name: "バナナマン",
      url: "http://com.horipro.co.jp/talent/%E3%83%90%E3%83%8A%E3%83%8A%E3%83%9E%E3%83%B3/index.html"
    )
    comedians << Comedian.new(
      name: "設楽統",
      url: "http://com.horipro.co.jp/talent/%E3%83%90%E3%83%8A%E3%83%8A%E3%83%9E%E3%83%B3/index.html"
    )
    comedians << Comedian.new(
      name: "日村勇紀",
      url: "http://com.horipro.co.jp/talent/%E3%83%90%E3%83%8A%E3%83%8A%E3%83%9E%E3%83%B3/index.html"
    )
    comedians << Comedian.new(
      name: "つぶやきシロー",
      url: "http://www.horipro.co.jp/tsubuyakishiro/"
    )
    comedians << Comedian.new(
      name: "ななめ45°",
      url: "http://com.horipro.co.jp/talent/%E3%81%AA%E3%81%AA%E3%82%8145%C2%B0/index.html"
    )
    comedians << Comedian.new(
      name: "X-GUN",
      url: "http://com.horipro.co.jp/talent/X-GUN/index.html"
    )
    comedians << Comedian.new(
      name: "たんぽぽ",
      url: "http://www.horipro.co.jp/tanpopo/"
    )
    comedians << Comedian.new(
      name: "白鳥久美子",
      url: "http://www.horipro.co.jp/tanpopo/"
    )
    comedians << Comedian.new(
      name: "川村エミコ",
      url: "http://www.horipro.co.jp/tanpopo/"
    )
    comedians << Comedian.new(
      name: "ホリ",
      url: "http://com.horipro.co.jp/talent/%E3%83%9B%E3%83%AA/index.html"
    )
    comedians << Comedian.new(
      name: "和田アキ子",
      url: "http://www.horipro.co.jp/wadaakiko/"
    )
    comedians << Comedian.new(
      name: "ダブルブッキング",
      url: "http://com.horipro.co.jp/talent/%E3%83%80%E3%83%96%E3%83%AB%E3%83%96%E3%83%83%E3%82%AD%E3%83%B3%E3%82%B0/index.html"
    )
    comedians << Comedian.new(
      name: "スピードワゴン",
      url: "http://com.horipro.co.jp/talent/%E3%82%B9%E3%83%94%E3%83%BC%E3%83%89%E3%83%AF%E3%82%B4%E3%83%B3/index.html"
    )
    comedians << Comedian.new(
      name: "井戸田潤",
      url: "http://com.horipro.co.jp/talent/%E3%82%B9%E3%83%94%E3%83%BC%E3%83%89%E3%83%AF%E3%82%B4%E3%83%B3/index.html"
    )
    comedians << Comedian.new(
      name: "小沢一敬",
      url: "http://com.horipro.co.jp/talent/%E3%82%B9%E3%83%94%E3%83%BC%E3%83%89%E3%83%AF%E3%82%B4%E3%83%B3/index.html"
    )
    comedians << Comedian.new(
      name: "磁石",
      url: "http://com.horipro.co.jp/talent/%E7%A3%81%E7%9F%B3/index.html"
    )
    comedians << Comedian.new(
      name: "ザ・たっち",
      url: "http://com.horipro.co.jp/talent/%E3%82%B6%E3%83%BB%E3%81%9F%E3%81%A3%E3%81%A1/index.html"
    )
    comedians << Comedian.new(
      name: "クワバタオハラ",
      url: "http://com.horipro.co.jp/talent/%E3%82%AF%E3%83%AF%E3%83%90%E3%82%BF%E3%82%AA%E3%83%8F%E3%83%A9/index.html"
    )
    comedians << Comedian.new(
      name: "くわばたりえ",
      url: "http://com.horipro.co.jp/talent/%E3%82%AF%E3%83%AF%E3%83%90%E3%82%BF%E3%82%AA%E3%83%8F%E3%83%A9/index.html"
    )
    comedians << Comedian.new(
      name: "小原正子",
      url: "http://com.horipro.co.jp/talent/%E3%82%AF%E3%83%AF%E3%83%90%E3%82%BF%E3%82%AA%E3%83%8F%E3%83%A9/index.html"
    )

    Comedian.import comedians

    first_id = Comedian.find_by(name: 'イジリー岡田').id
    last_id = Comedian.find_by(name: '小原正子').id

    comedians_companies = []
    Comedian.where("id >= ? and id <= ?", first_id, last_id).each do |comedian|
      comedians_companies << ComediansCompany.new(
        comedian_id: comedian.id,
        company_id: Company::HORIPRO_ID
      )
    end

    ComediansCompany.import comedians_companies
  end

  task :jinrikisha => :environment do
    names = [ "大久保佳代子", "光浦靖子", "児嶋一哉", "渡部建", "山崎弘也", "柴田英嗣", "小木博明", "矢作兼", "鈴木拓",
      "塚地武雅" ]
    LIST_URL = 'http://www.p-jinriki.com/talent/'

    browser = Watir::Browser.new(:phantomjs)
    browser.goto(LIST_URL)
    doc = Nokogiri::HTML.parse(browser.html)
    doc.css('div.talent_name').each do |talent_name|
      names << talent_name.css('h2').inner_text
    end

    names.each do |n|
      comedian = Comedian.create(name: n)
      ComediansCompany.create(comedian: comedian, company_id: Company::JINRIKISHA_ID)
    end
  end

  task :watanabe => :environment do
    names = ["原田泰造", "名倉潤", "堀内健", "石塚英彦", "恵俊彰", "田中卓志"]
    LIST_URL = 'http://www.watanabepro.co.jp/artist/500/'

    browser = Watir::Browser.new(:phantomjs)
    browser.goto(LIST_URL)
    doc = Nokogiri::HTML.parse(browser.html)
    doc.css('div.ArtistProf').each do |prof|
      names << prof.css('h3').inner_text
    end

    names.each do |n|
      comedian = Comedian.create(name: n)
      ComediansCompany.create(comedian: comedian, company_id: Company::WATANABE_ID)
    end
  end

  task :otapro => :environment do
    names = ["有吉弘行", "アルコ＆ピース", "インスタントジョンソン", "劇団ひとり",
      "タイムマシーン3号", "土田晃之", "ダチョウ倶楽部", "マシンガンズ", "柳原可奈子"]
    names.each do |n|
      comedian = Comedian.create(name: n)
      ComediansCompany.create(comedian: comedian, company_id: Company::OTAPRO_ID)
    end
  end

  task :maseki => :environment do
    names = [
      "ウッチャンナンチャン", "出川哲朗", "バカリズム", "いとうあさこ", "ナイツ", "三四郎", "狩野英孝",
      "内村光良", "南原清隆", "小宮浩信"
    ]
    names.each do |n|
      comedian = Comedian.create(name: n)
      ComediansCompany.create(comedian: comedian, company_id: Company::MASEKI_ID)
    end
  end

  task :others => :environment do
    names = [
      "ビートたけし", "浅草キッド", "ガダルカナル・タカ",
      "小堺一機", "関根勉", "キャイ～ン", "ずん", "天野ひろゆき", "ウド鈴木",
      "タモリ", "とんねるず", "石橋貴明", "木梨憲武", "くりぃむしちゅー", "上田晋也", "有田哲平",
      "爆笑問題", "太田光", "田中裕二"
    ]
    names.each do |n|
      comedian = Comedian.create(name: n)
      ComediansCompany.create(comedian: comedian, company_id: Company::OTHERS_ID)
    end
  end
end
