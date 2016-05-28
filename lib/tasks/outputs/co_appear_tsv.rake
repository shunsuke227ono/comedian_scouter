require 'csv'

namespace :co_appear_csv do
  task :execute => :environment do
    comedians = Comedian.includes(:co_appears).all.index_by(&:name)

    co_appears = CoAppear.all.index_by { |c| [c.comedian_id_1, c.comedian_id_2] }
    co_appears_by_id_1 = CoAppear.all.index_by(&:comedian_id_1)
    co_appears_by_id_2 = CoAppear.all.index_by(&:comedian_id_2)

    CSV.open('co_appears.csv', 'wb') do |csv|
      csv << [nil] + comedians.map { |n, c| n if c.co_appears.present? }.compact
      comedians.each do |name, comedian|
        next if comedian.co_appears.blank?
        row = [name]
        comedians.each do |n, c|
          key = [[comedian.id, c.id].min, [comedian.id, c.id].max]
          count = co_appears[key].try(:count) || 0
          row << count
        end
        csv << row
      end
    end

    def appeared?(comedian)
      # TODO: ゼロ消す処理
      # TODO: そもそも出演回数は共演回数とは別に数えてやればいい。
    end
  end

  task :to_tsv => :environment do
    File.open('co_appears.tsv', 'w') do |out|
      CSV.foreach('co_appears.csv') do |l|
        out.write(l.join("\t")+"\n")
      end
    end
  end
end
