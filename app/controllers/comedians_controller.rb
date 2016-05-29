class ComediansController < ApplicationController
  def index
    @comedians = Comedian.includes(:company).where("has_monthly_appears > 10").order(appear_count: :desc)
  end

  def analysis
    @comedian = Comedian.find(params[:id])
    @rank = Comedian.where("appear_count > ?", @comedian.appear_count).count + 1
    @whole_n = Comedian.count

    @growths = @comedian.growths.index_by(&:year)

    number = params[:number] || 10
    @co_appears = CoAppear.all_pairs(@comedian.id).order(count: :desc).limit(number)
  end

  def map_data
    comedian = Comedian.find(params[:id])

    co_appears = CoAppear.all_pairs(comedian.id).order(count: :desc).limit(20)
    comedian_ids = co_appears.pluck(:comedian_id_1) + co_appears.pluck(:comedian_id_2)

    comedians = Comedian.find(comedian_ids)
    co_appears = CoAppear.all_pairs_of_ids(comedian_ids).where("count > 10")

    data = {
      "nodes": [],
      "links": []
    }

    comedians.each do |c|
      data[:nodes] << {
        "id": c.id,
        "name": c.name,
        "appearcount": c.appear_count,
        "company": c.company.name,
      }
    end

    co_appears.each do |c|
      data[:links] << {
        "source": c.comedian_id_1,
        "target": c.comedian_id_2,
        "value": c.count
      }
    end

    render :json => data
  end

  def history_data
    dates = []
    date = Date.new(2010, 4, 1)
    while date < Date.new(2016, 4, 1)
      dates << date
      date += 1.month
    end

    data = []

    if params[:id] == "0"
      last_appear = 0
      dates.each_with_index do |date, i|
        appear = MonthlyAppear.where(start_date: date).where("count > 5").average(:count) || 0
        data << {
          i: i,
          date: date.to_s,
          appear: appear,
          increasing: appear > last_appear
        }
        last_appear = appear
      end
    else
      @comedian = Comedian.find(params[:id])
      monthly_appears = @comedian.monthly_appears.index_by(&:start_date)
      last_appear = 0
      dates.each_with_index do |date, i|
        appear = monthly_appears[date].try(:count) || 0
        data << {
          i: i,
          date: date.to_s,
          appear: appear,
          increasing: appear > last_appear
        }
        last_appear = appear
      end
    end

    render :json => data
  end
end
