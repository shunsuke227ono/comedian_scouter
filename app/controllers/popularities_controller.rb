class PopularitiesController < ApplicationController
  def index
  end

  def appear_ranking_data
    comedians = Comedian.includes(:company).where("appear_count > 5").order(appear_count: :desc)

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
end
