class PopularitiesController < ApplicationController
  def index
  end

  def appear_ranking_data
    comedians = Comedian.includes(:company).where("appear_count > 50").order(appear_count: :desc)

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
    @comedians = Comedian.all
  end

  def history
    @comedian = Comedian.find(params[:id])
  end

  def history_data
    @comedian = Comedian.find(params[:id])
    monthly_appears = @comedian.monthly_appears.index_by(&:start_date)

    dates = []
    date = Date.new(2010, 4, 1)
    while date < Date.new(2016, 4, 1)
      dates << date
      date += 1.month
    end

    data = []
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

    render :json => data
  end
end
