class PopularitiesController < ApplicationController
  def index
    @comedians = Comedian.includes(:company).order(appear_count: :desc).limit(50)
    @growths = Growth.where(year: '2015/04/01', comedian_id: @comedians.ids).index_by(&:comedian_id)
  end

  def appear_ranking_data
    comedians = Comedian.includes(:company).order(appear_count: :desc).limit(50)

    data = []
    comedians.each_with_index do |c, i|
      data << {
        name: c.name,
        company: c.company.name,
        appear_count: c.appear_count,
        rank: i+1
      }
    end

    render :json => data
  end

  def search
    @comedians = Comedian.where("has_monthly_appears > 15")
  end

  def history
    unless params[:id] == "0"
      @comedian = Comedian.find(params[:id])
    end
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
