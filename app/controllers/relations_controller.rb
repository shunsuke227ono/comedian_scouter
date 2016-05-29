class RelationsController < ApplicationController

  def index
  end

  def map_data
    data = {
      "nodes": [],
      "links": []
    }

    min_count = 30
    comedians = Comedian.includes(:company).where("appear_count > #{min_count}")

    comedians.each do |c|
      data[:nodes] << {
        "id": c.id,
        "name": c.name,
        "appearcount": c.appear_count,
        "company": c.company.name,
      }
    end

    min_relation = 10

    CoAppear.all_pairs_of_ids(comedians.ids).where("count > #{min_relation}").each do |c|
      data[:links] << {
        "source": c.comedian_id_1,
        "target": c.comedian_id_2,
        "value": c.count
      }
    end

    render :json => data
  end

  def search
    @comedians = Comedian.includes(:company)
  end

  def show
    # NOTE: 特定の芸人に関して調べる
    # TODO: グラフで見せても良いな
    @comedian = Comedian.find(params[:id])
    number = params[:number] || 10
    @co_appears = CoAppear.all_pairs(@comedian.id).order(count: :desc).limit(number)
  end
end
