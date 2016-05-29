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

  def history
    @comedian = Comedian.find(params[:id])
  end

  def history_data
    @comedian = Comedian.find(params[:id])
    monthly_appears = @comedian.monthly_appears.index_by(&:start_date)

    data = []
    render :json => data
  end
end
